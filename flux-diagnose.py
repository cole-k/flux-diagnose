import json
import os
import sys
import subprocess
import shutil
from pathlib import Path  # Import Path from pathlib
from collections import defaultdict  # Import defaultdict for counting
import argparse  # Import argparse for command-line argument parsing

CONTEXT_WINDOW = 3
LOG_DIRECTORY = "log"
DEFAULT_OUTPUT_DIR = Path("flux-diagnostics")  # Use Path for output directory

def parse_flux_json(json_output, log_directory, output_directory):
    """
    Parses the JSON output from the Flux tool and extracts relevant error details.
    Only error messages are retained, while warnings are discarded.
    """
    errors = []
    error_count_map = defaultdict(int)  # Initialize a default dictionary for counting errors

    for raw_data in json_output:
        data = json.loads(raw_data)
            
        # Check if the message is of type 'compiler-message' and if the message is an error
        if data.get("reason") == "compiler-message":
            message = data.get("message", {})
            spans = message.get("spans", [])
            
            # Only process if the message level is 'error'
            if message.get("level") == "error":
                for span in spans:
                    row = span.get("line_start")  # Get the row number

                    error_info = {
                        "message": message.get("message"),
                        "file": span.get("file_name"),
                        "row": row,
                        "col": span.get("column_start"),
                        "raw": message.get("rendered"),
                    }
                    error_info["function_context"] = extract_function_context(error_info["file"], error_info["row"], log_directory, output_directory)

                    # Now that we have the function context, we can get the actual function name
                    function_name = error_info["function_context"]["name"]

                    # Generate a unique error name
                    n = error_count_map[(function_name, row)]
                    unique_name = f"{function_name}-L{row}-{n}"
                    error_count_map[(function_name, row)] += 1

                    error_info["unique_name"] = unique_name  # Add the unique name to the error info
                    errors.append(error_info)
    
    return errors

def extract_function_context(file_name, error_line, log_directory, output_directory):
    """
    Extracts the function context from the specified file at the given error line.
    Returns the start and end line numbers of the function, along with the function name
    and a list of constraint files that match the function name.
    """
    with open(file_name, 'r') as file:
        lines = file.readlines()
    
    function_start = None
    function_end = None
    metadata_start = None
    function_name = None

    # Go backwards to find the function definition
    for i in range(error_line - 1, -1, -1):
        line = lines[i].strip()
        if line.startswith("fn "):
            function_start = i + 1  # Store the line number (1-based)
            function_name = line.split()[1].split('(')[0]  # Get the name before the '('
            break
        elif line.startswith("pub fn "):
            function_start = i + 1  # Store the line number (1-based)
            function_name = line.split()[2].split('(')[0]  # Get the name before the '('
            break
    metadata_start = function_start
    for i in range(function_start - 1, -1, -1):
        line = lines[i].lstrip()
        if line.startswith("#") or line.startswith("//") or not line:
            metadata_start = i + 1  # Update metadata start line
            break
    
    # If we found the function start, now find the end
    if function_start is not None:
        brace_count = 0
        for i in range(function_start - 1, len(lines)):
            line = lines[i]
            brace_count += line.count('{')
            brace_count -= line.count('}')
            if brace_count == 0:
                function_end = i + 1  # Store the line number (1-based)
                break
    
    # Find constraint files in the log directory
    destination_log_dir = output_directory / "all_constraints"
    os.makedirs(destination_log_dir, exist_ok=True)  # Create the log directory if it doesn't exist
    constraint_files = []
    if function_name:
        for root, dirs, files in os.walk(log_directory):
            for file in files:
                if (function_name + "." in file):
                    # Copy the file to the output directory
                    source_path = Path(root) / file
                    destination_path = destination_log_dir / file
                    shutil.copy(source_path, destination_path)  # Copy the file
                    constraint_files.append(destination_path)  # Add the new path to the list
                    # print(f"Copied {source_path} to {destination_path}")
    
    return {
        "start": metadata_start if metadata_start else function_start,
        "end": function_end,
        "name": function_name,
        # Convert constraint files to strings for rendering. If we need the actual paths, we can fix this later.
        "constraint_files": [str(file) for file in constraint_files]
    }

def print_function_context(error):
    """
    Print the function context for the specified error.
    """
    # Print the line with context
    start_line = error["function_context"]["start"]
    end_line = error["function_context"]["end"]
    function_name = error["function_context"]["name"]

    print(f"\nFunction context (lines {start_line} to {end_line}):")
    print(f"Function name: {function_name}")
    
    with open(error["file"], 'r') as f:
        context_lines = f.readlines()[start_line - 1:end_line]  # Adjust for 0-based index
        
        for index, context_line in enumerate(context_lines, start=start_line):
            print(f"{index:2d}: {context_line.rstrip()}")

def gather_fix_info_from_user(error):
    """
    Gather information about the fix for the specified error from user input.
    """
    
    print(error["raw"])
    print_function_context(error)
    print()

    fix_line = int(input(f"Enter the line number that needs to change to fix the error (press Enter for {error['row']}): ") or error["row"])

    # Ask if the error message is helpful enough
    helpful_message = input("Is the error message helpful enough? (y/n): ").strip().lower()
    
    # Print the line with context
    start_line = error["function_context"]["start"]
    end_line = error["function_context"]["end"]
    function_name = error["function_context"]["name"]
    
    with open(error["file"], 'r') as f:
        context_lines = f.readlines()[fix_line - (CONTEXT_WINDOW + 1) : fix_line + CONTEXT_WINDOW]  # Adjust for 0-based index
        
        for index, context_line in enumerate(context_lines, start=fix_line - CONTEXT_WINDOW):
            print(f"{index:2d}: {'error->' if index == fix_line else '       '}{context_line.rstrip()}")

    # Ask for the problem on the indicated line
    problem_choice = input("What is the problem on the line you indicated? (1: Code is wrong, 2: Refinement not specific enough, 3: Incorrect refinement, 4: Other): ")
    
    fix_description = {}
    if problem_choice == '1':
        fix_description = {
            "fix_type": "code_change",
            "description": input("Please describe the fix: ")
        }
    elif problem_choice == '2':
        fix_description = {
            "fix_type": "additional_refinement",
            "description": input("Please describe the additional refinement needed: ")
        }
    elif problem_choice == '3':
        fix_description = {
            "fix_type": "new_refinement",
            "description": input("Please describe the correct refinement: ")
        }
    elif problem_choice == '4':
        fix_description = {
            "fix_type": "other",
            "description": input("Please describe the issue: ")
        }

    # Record the information in a structured format
    fix_info = {
        "fix_line": fix_line,
        "helpful_message": helpful_message,
        "problem_description": problem_choice,
        "fix_description": fix_description
    }

    return fix_info

def run_flux(directory_to_run_flux_in):
    """
    Run the Flux tool in the specified directory and capture its output.
    """
    # Change to the specified directory
    os.chdir(directory_to_run_flux_in)

    # Get the current git commit hash
    try:
        commit_hash = subprocess.check_output(["git", "rev-parse", "--short", "HEAD"]).strip().decode('utf-8')
    except subprocess.CalledProcessError:
        commit_hash = None  # Not in a git repository

    # Run the Flux command
    command = "FLUX_DUMP_CONSTRAINT=1 cargo flux --message-format=json"
    result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)

    # Capture the output
    json_output = result.stdout.decode('utf-8').splitlines()

    return json_output, commit_hash

# Example usage
if __name__ == "__main__":
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Run Flux diagnostics and gather error information.")
    parser.add_argument("directory_to_run_flux_in", help="Directory to run Flux in.")
    parser.add_argument("--output-directory", type=Path, default=DEFAULT_OUTPUT_DIR, help="Directory to save output.")
    parser.add_argument("--ignore-cache", action='store_true', help="Ignore caches, overwriting existing ones.")
    
    args = parser.parse_args()

    directory_to_run_flux_in = args.directory_to_run_flux_in
    output_directory = Path(args.output_directory).resolve()

    # Create the output directory if it doesn't exist
    os.makedirs(output_directory, exist_ok=True)

    # Run Flux and capture the output
    json_output, commit_hash = run_flux(directory_to_run_flux_in)
    by_commit_hash_dir = output_directory / commit_hash if commit_hash else output_directory

    # Parse the JSON output
    parsed_errors = parse_flux_json(json_output, directory_to_run_flux_in + '/log', by_commit_hash_dir)
    print(f"Total errors found: {len(parsed_errors)}\n")

    # Save error and fix information
    for error in parsed_errors:
        error_name = error["unique_name"]
        error_dir = by_commit_hash_dir / error_name
        os.makedirs(error_dir, exist_ok=True)

        # if error file exists already and we are not forcing, skip
        if not args.ignore_cache and (error_dir / "error_and_fix.json").exists():
            print(f"Skipping {error_name} because it already exists")
            continue

        # Save error and fix information to a JSON file
        error_and_fix_info = {
            "error": error,
            "fix": gather_fix_info_from_user(error)  # Gather fix information
        }
        with open(error_dir / "error_and_fix.json", 'w') as f:
            json.dump(error_and_fix_info, f, indent=4)

        # Save constraint files
        for constraint in error["function_context"]["constraint_files"]:
            shutil.copy(constraint, error_dir / Path(constraint).name)  # Copy constraint files to the error directory

        print(f"Saved error and fix information for {error_name} to {error_dir}")