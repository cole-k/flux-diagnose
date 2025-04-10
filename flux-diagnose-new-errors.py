# flux-diagnose-new-errors.py

import json
import os
import sys
import subprocess
import shutil
import re
from pathlib import Path
from collections import defaultdict
import argparse

CONTEXT_WINDOW = 3
DEFAULT_LOG_DIRECTORY = "log"
DEFAULT_OUTPUT_DIR = Path("flux-diagnostics-new")

# --- Regex for parsing the second error message ---
# Captures: 1=predicate, 2=blamed_variable, 3=related_variables (as string)
ERROR_DETAIL_REGEX = re.compile(
    r'failed to verify predicate:\s*"(?P<predicate>.*?)"\s*'
    r'blamed variable:\s*"(?P<blamed_variable>.*?)"\s*'
    r'related variables:\s*(?P<related_variables>\[.*?\])',
    re.DOTALL | re.IGNORECASE
)

def parse_flux_json(json_output, flux_run_directory, log_directory, output_directory, ignore_file_prefix):
    """
    Parses the JSON output from Flux, pairing consecutive error messages
    and extracting detailed information from the second message.
    """
    errors = []
    error_count_map = defaultdict(int)
    potential_first_error = None
    iterator = iter(enumerate(json_output))

    # for i, raw_data in iterator:
    #     try:
    #         data = json.loads(raw_data)
    #     except json.JSONDecodeError:
    #         # print(f"Warning: Skipping non-JSON line: {raw_data}", file=sys.stderr)
    #         continue # Ignore non-json cargo output

    #     # Check if it's a compiler message
    #     if data.get("reason") != "compiler-message":
    #         continue

    #     message = data.get("message", {})
    #     spans = message.get("spans", [])

    #     # Only process primary spans of error messages
    #     if message.get("level") != "error" or not spans or not spans[0].get("is_primary"):
    #         continue

    #     current_error_span = spans[0]
    #     current_error_loc = (
    #         current_error_span.get("file_name"),
    #         current_error_span.get("line_start"),
    #         current_error_span.get("column_start")
    #     )

    #     # --- Logic for Pairing Errors ---
    #     # Check if the *next* message is the paired detail message
    #     try:
    #         next_i, next_raw_data = next(iterator)
    #         next_data = json.loads(next_raw_data)

    #         if (next_data.get("reason") == "compiler-message" and
    #             (next_message := next_data.get("message", {})) and
    #             next_message.get("level") == "error" and
    #             (next_spans := next_message.get("spans", [])) and
    #             next_spans and next_spans[0].get("is_primary")):

    #             next_error_span = next_spans[0]
    #             next_error_loc = (
    #                 next_error_span.get("file_name"),
    #                 next_error_span.get("line_start"),
    #                 next_error_span.get("column_start")
    #             )

    #             # Heuristic: If the primary span location matches, assume it's the paired error
    #             if current_error_loc == next_error_loc:
    #                 # Found a pair! Process them together
    #                 file_name = current_error_span.get("file_name")
    #                 if ignore_file_prefix and file_name.startswith(ignore_file_prefix):
    #                      file_name = file_name[len(ignore_file_prefix):]

    #                 error_info = {
    #                     "message1": message.get("message"),
    #                     "message2": next_message.get("message"),
    #                     "file": file_name,
    #                     "row": current_error_span.get("line_start"),
    #                     "col": current_error_span.get("column_start"),
    #                     "raw1": message.get("rendered"),
    #                     "raw2": next_message.get("rendered"),
    #                     "predicate": None,
    #                     "blamed_variable": None,
    #                     "related_variables": [],
    #                     "parsing_error": None # Field to note if second message parsing failed
    #                 }

    #                 # Parse details from the second message's text
    #                 detail_match = ERROR_DETAIL_REGEX.search(error_info["message2"])
    #                 if detail_match:
    #                     error_info["predicate"] = detail_match.group("predicate")
    #                     error_info["blamed_variable"] = detail_match.group("blamed_variable")
    #                     try:
    #                         # The related_variables part is tricky as it's JSON embedded in a string
    #                         related_vars_str = detail_match.group("related_variables")
    #                         error_info["related_variables"] = json.loads(related_vars_str)
    #                     except json.JSONDecodeError as e:
    #                          error_info["parsing_error"] = f"Failed to parse related_variables JSON: {e}. String was: {detail_match.group('related_variables')}"
    #                          print(f"Warning: {error_info['parsing_error']}", file=sys.stderr)
    #                     except Exception as e:
    #                          error_info["parsing_error"] = f"Unexpected error parsing related_variables: {e}. String was: {detail_match.group('related_variables')}"
    #                          print(f"Warning: {error_info['parsing_error']}", file=sys.stderr)

    #                 else:
    #                     error_info["parsing_error"] = "Regex did not match expected format for second error message."
    #                     print(f"Warning: {error_info['parsing_error']} Message was: {error_info['message2']}", file=sys.stderr)


    #                 # Extract function context (using the first error's location)
    #                 error_info["function_context"] = extract_function_context(
    #                     current_error_span.get("file_name"), # Use original full path here
    #                     error_info["row"],
    #                     log_directory,
    #                     output_directory
    #                 )

    #                 # Generate unique name
    #                 function_name = error_info["function_context"]["name"] or "unknown_fn"
    #                 row = error_info["row"]
    #                 n = error_count_map[(function_name, row)]
    #                 unique_name = f"{function_name}-L{row}-{n}"
    #                 error_count_map[(function_name, row)] += 1
    #                 error_info["unique_name"] = unique_name

    #                 errors.append(error_info)
    #                 # Skip the next item since we consumed it
    #                 continue # Goes to the next iteration of the outer loop

    #         # If we got here, the next item wasn't the pair. We need to put it back.
    #         # This requires a more complex iterator or lookahead buffer.
    #         # For simplicity, this version *assumes* pairs always exist if an error is found.
    #         # A more robust implementation would handle lone errors.
    #         # Given the prompt "every error has two separate messages", we assume this holds.
    #         # If it wasn't a pair, we should technically re-evaluate `next_raw_data` in the next loop.
    #         # The current `iter/next` approach consumes it. Let's refine this.

    #     except StopIteration:
    #         # Reached the end of the iterator after processing the first error
    #         print(f"Warning: Found a potential first error message at the end of output without a following message: {message.get('message')}", file=sys.stderr)
    #         pass # Or handle the lone error if needed
    #     except json.JSONDecodeError:
    #          # print(f"Warning: Skipping non-JSON line after potential first error: {next_raw_data}", file=sys.stderr)
    #          pass # Ignore non-json cargo output
    #     except Exception as e:
    #         print(f"Error processing potential pair for message {i}: {e}", file=sys.stderr)


    # --- Refined Pairing Logic ---
    # The above iter/next logic is tricky. Let's try iterating with indices.
    errors = []
    error_count_map = defaultdict(int)
    i = 0
    parsed_data = []
    for raw_line in json_output:
        try:
            parsed_data.append(json.loads(raw_line))
        except json.JSONDecodeError:
            # print(f"Warning: Skipping non-JSON line: {raw_line}", file=sys.stderr)
            parsed_data.append(None) # Keep indices aligned

    while i < len(parsed_data):
        data = parsed_data[i]
        i += 1 # Consume current item

        if data is None \
           or data.get("reason") != "compiler-message" \
           or (message := data.get("message", {})) is None \
           or message.get("level") != "error" \
           or not (spans := message.get("spans", [])) \
           or not spans[0].get("is_primary"):
            continue

        # Found a potential first error message
        current_error_span = spans[0]
        current_error_loc = (
            current_error_span.get("file_name"),
            current_error_span.get("line_start"),
            current_error_span.get("column_start")
        )

        # Look at the next item
        if i < len(parsed_data) and (next_data := parsed_data[i]) is not None:
             if (next_data.get("reason") == "compiler-message" and
                (next_message := next_data.get("message", {})) and
                next_message.get("level") == "error" and
                (next_spans := next_message.get("spans", [])) and
                next_spans and next_spans[0].get("is_primary")):

                next_error_span = next_spans[0]
                next_error_loc = (
                    next_error_span.get("file_name"),
                    next_error_span.get("line_start"),
                    next_error_span.get("column_start")
                )

                # Heuristic: If the primary span location matches, assume it's the paired error
                if current_error_loc == next_error_loc:
                    # --- Process the Pair ---
                    i += 1 # Consume the second item as well

                    file_name = current_error_span.get("file_name")
                    # Use original full path for context extraction
                    original_full_path = str(Path(flux_run_directory) / file_name)

                    if ignore_file_prefix and file_name and file_name.startswith(ignore_file_prefix):
                         file_name = file_name[len(ignore_file_prefix):]

                    error_info = {
                        "message1": message.get("rendered"),
                        "message2": next_message.get("rendered"),
                        "file": original_full_path,
                        "row": current_error_span.get("line_start"),
                        "col": current_error_span.get("column_start"),
                        "raw1": message.get("rendered"),
                        "raw2": next_message.get("rendered"),
                        "predicate": None,
                        "blamed_variable": None,
                        "related_variables": [],
                        "parsing_error": None # Field to note if second message parsing failed
                    }

                    # Parse details from the second message's text
                    detail_match = ERROR_DETAIL_REGEX.search(error_info["message2"])
                    if detail_match:
                        error_info["predicate"] = detail_match.group("predicate").strip()
                        error_info["blamed_variable"] = detail_match.group("blamed_variable").strip()
                        try:
                            related_vars_str = detail_match.group("related_variables")
                            error_info["related_variables"] = json.loads(related_vars_str)
                        except json.JSONDecodeError as e:
                             error_info["parsing_error"] = f"Failed to parse related_variables JSON: {e}. String was: {detail_match.group('related_variables')}"
                             print(f"Warning: {error_info['parsing_error']}", file=sys.stderr)
                        except Exception as e:
                             error_info["parsing_error"] = f"Unexpected error parsing related_variables: {e}. String was: {detail_match.group('related_variables')}"
                             print(f"Warning: {error_info['parsing_error']}", file=sys.stderr)
                    else:
                        error_info["parsing_error"] = "Regex did not match expected format for second error message."
                        print(f"Warning: {error_info['parsing_error']} Message was: {error_info['message2']}", file=sys.stderr)

                    # Extract function context (using the first error's location)
                    # Need to handle case where file doesn't exist relative to current dir
                    try:
                        error_info["function_context"] = extract_function_context(
                            original_full_path, # Use original full path here
                            error_info["row"],
                            log_directory,
                            output_directory
                        )
                    except FileNotFoundError:
                         print(f"Warning: Could not find file {original_full_path} for context extraction.", file=sys.stderr)
                         # Provide default empty context
                         error_info["function_context"] = {
                            "start": None, "end": None, "name": None, "constraint_files": [], "rendered_context": "File not found for context."
                         }


                    # Generate unique name
                    function_name = error_info["function_context"]["name"] or "unknown_fn"
                    row = error_info["row"]
                    n = error_count_map[(function_name, row)]
                    unique_name = f"{function_name}-L{row}-{n}"
                    error_count_map[(function_name, row)] += 1
                    error_info["unique_name"] = unique_name

                    errors.append(error_info)
                    continue # Skip to next iteration of while loop

        # If we reached here, the first error message didn't have a valid pair following it.
        # Log this, as it violates the assumption.
        print(f"Warning: Found potential primary error message without a valid paired message following it.", file=sys.stderr)
        print(f"  Message: {message.get('message')}", file=sys.stderr)
        print(f"  Location: {current_error_loc}", file=sys.stderr)


    return errors


def extract_function_context(file_path_str, error_line, log_directory, output_directory):
    """
    Extracts the function context from the specified file at the given error line.
    Returns the start and end line numbers of the function, along with the function name
    and a list of constraint files that match the function name.
    """
    file_path = Path(file_path_str)
    if not file_path.is_file():
        raise FileNotFoundError(f"Cannot find file for context extraction: {file_path_str}")

    with open(file_path, 'r') as file:
        lines = file.readlines()

    function_start = None
    function_end = None
    metadata_start = None
    function_name = None

    # Define the regex pattern to find Rust function definitions and capture the name
    # ^                 - Start of the string (line)
    # \s*               - Optional leading whitespace (though strip() mostly handles this)
    # (?:pub\s+)?       - Optional non-capturing group for "pub " followed by whitespace
    # (?:unsafe\s+)?    - Optional non-capturing group for "unsafe " followed by whitespace
    # fn\s+             - The literal "fn" followed by one or more whitespace characters
    # ([a-zA-Z_][a-zA-Z0-9_]*) - Capturing group 1: the function name
    #                           (starts with letter/underscore, followed by alphanumeric/underscore)
    #                           This pattern implicitly stops before '<' or '('
    FUNC_DEF_PATTERN = re.compile(r"^\s*(?:pub\s+)?(?:unsafe\s+)?fn\s+([a-zA-Z_][a-zA-Z0-9_]*)")
    
    # Go backwards from the line before the error to find the function definition
    for i in range(error_line - 1, -1, -1):
        # Strip leading/trailing whitespace just in case
        line = lines[i].strip()
    
        # Try to match the function definition pattern at the beginning of the line
        match = FUNC_DEF_PATTERN.match(line)
    
        if match:
            function_start = i + 1      # Store the line number (1-based)
            function_name = match.group(1) # Extract the captured function name (Group 1)
            break # Found the function definition, no need to search further back
    
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

def render_function_context(error):
    """
    Render the function context for the specified error as a string.
    Handles cases where start/end might be None.
    """
    start_line = error["function_context"]["start"]
    end_line = error["function_context"]["end"]
    function_name = error["function_context"]["name"]
    file_path_str = error["file"] # Use the potentially shortened path for display

    if start_line is None or end_line is None:
        return f"\nFunction context for '{function_name}' not found or file missing.\n"

    header = f"\nFunction context ({file_path_str}:{start_line}-{end_line}):"
    name_line = f"Function name: {function_name}"
    rendered_context = header + "\n" + name_line + "\n" + "-" * len(header) + "\n"

    try:
        # Reconstruct full path if needed for reading - depends on CWD
        # Assuming the 'file' in error might be relative if ignore-prefix was used
        # Let's try opening it as is first, assuming CWD or PATH is correct
        # A better approach might store the original absolute path separately.
        # For now, assume `error["file"]` can be opened from the script's CWD,
        # or that `ignore-file-prefix` makes it relative to the project root.
        # We passed the original full path to extract_function_context,
        # so let's try opening that one instead.
        # Need to get the original path back - let's add it to error_info if stripped.
        # --- RETHINK --- extract_function_context *requires* the real path.
        # Let's assume the `error["file"]` is the one relative to the project root,
        # and we need to combine it with the project dir passed as argument.
        # This gets complicated. Simplest: try opening `error["file"]`. If that fails,
        # print a warning. The original `flux-diagnose` read from `error["file"]`.

        file_to_open = Path(error["file"])
        # If ignore_file_prefix was used, error["file"] might be relative. Assume it's
        # relative to the directory where flux was run (passed as arg).
        # This needs the `directory_to_run_flux_in` argument passed down or accessible globally.
        # Let's require the user runs this script from the same CWD as the original run for now.
        # Or, modify run_flux to return the original CWD.

        # --- Simplified approach: ---
        # Assume error["file"] is relative to the CWD *when the script is run*.
        # This is fragile.
        # A better fix: Store the absolute path in error_info during parsing.

        # Let's assume `extract_function_context` succeeded, which means the file *was* accessible
        # using the original full path. Let's try to use that path again if available.
        # The original script just used error['file']. Let's stick to that for now and see if it breaks.

        with open(error["file"], 'r') as f:
            # Read all lines then slice to avoid issues with large files if only reading part
            all_lines = f.readlines()
            context_lines = all_lines[start_line - 1 : end_line] # Adjust for 0-based index

            for index, context_line in enumerate(context_lines, start=start_line):
                prefix = "error>" if index == error["row"] else "      "
                rendered_context += f"{index:4d}: {prefix} {context_line.rstrip()}\n"

    except FileNotFoundError:
         rendered_context += f"\n*** Warning: Could not open file '{error['file']}' to render context. ***\n"
    except Exception as e:
         rendered_context += f"\n*** Warning: Error reading file '{error['file']}' for context: {e} ***\n"


    return rendered_context


def gather_fix_info_from_user(error):
    """
    Gather information about the fix for the specified error from user input,
    based on the new requirements.
    """
    print("-" * 30)
    print("Please provide feedback on this error:")

    # [step 0] Seen before?

    seen_before = input(' Have you seen this error before? (y/n): ').strip().lower().startswith('y')
    if seen_before:
        return { "seen_before": True }

    certainty = input(" Do you know for sure where the error is? (y/n): ").strip().lower().startswith("y")

    err_type = ''
    while err_type not in ['1a', '1b', '2a', '2b']:
	    err_type = input(" What kind of type failure is this?\n  1: postcondition failed for outer function\n  2: precondition on a function call fails\n\n  a: because some other function needs postcondition \n  b: because outer function needs precondition\n")

    problem_choice = input(" What is the problem? (1: Code is wrong, 2: Refinement not specific enough, 3: Incorrect refinement, 4: Other): ")

    fix_description = {}
    if problem_choice == '1':
        fix_description = {
            "fix_type": "code_change",
            "description": input(" Please describe the fix: ")
        }
    elif problem_choice == '2':
        fix_description = {
            "fix_type": "additional_refinement",
            "description": input(" Please describe the additional refinement needed: ")
        }
    elif problem_choice == '3':
        fix_description = {
            "fix_type": "new_refinement",
            "description": input(" Please describe the correct refinement: ")
        }
    elif problem_choice == '4':
        fix_description = {
            "fix_type": "other",
            "description": input(" Please describe the issue: ")
        }

    # [a] Blamed variable correct?
    blamed_var = error.get("blamed_variable", "N/A")
    blamed_correct_input = input(f" [a] Is the blamed variable '{blamed_var}' correct? (y/n): ").strip().lower()
    blamed_variable_correct = blamed_correct_input.startswith('y')

    # [b] Which related variables need changing?
    related_vars = error.get("related_variables", [])
    variables_to_change = []
    if related_vars:
        print("\n [b] Related variables:")
        for idx, var_info in enumerate(related_vars):
            # Format nicely: name (depth D, origin: O)
            origin = var_info.get('origin', 'unknown')
            # Strip redundant quotes from origin if present
            if isinstance(origin, str) and origin.startswith('"') and origin.endswith('"'):
                 origin = origin[1:-1]
            print(f"   {idx + 1}: {var_info.get('name', 'N/A')} (depth {var_info.get('depth', '?')}, origin: {origin})")

        while True:
            change_input = input("     Enter numbers of variables that need changing to fix the error (comma-separated, or Enter for none): ").strip()
            if not change_input:
                break
            try:
                indices = [int(x.strip()) - 1 for x in change_input.split(',')]
                # Validate indices
                valid = True
                selected_vars = []
                for index in indices:
                    if 0 <= index < len(related_vars):
                        selected_vars.append(related_vars[index])
                    else:
                        print(f"     Error: Index {index + 1} is out of range (1-{len(related_vars)}).")
                        valid = False
                        break
                if valid:
                    variables_to_change = selected_vars # Store the actual variable info objects
                    break
            except ValueError:
                print("     Error: Invalid input. Please enter numbers separated by commas.")
    else:
        print("\n [b] No related variables listed for this error.")

    # [c] Anything missing?
    anything_missing_input = input("\n [c] Is anything missing from the error message or related variables? (y/n): ").strip().lower()
    anything_missing = anything_missing_input.startswith('y')
    missing_info = ""
    if anything_missing:
        missing_info = input("     What is missing? ").strip()

    # [e] Additional notes
    additional_notes = input("\n [e] Any additional notes? (Optional): ").strip()

    print("-" * 30)

    # Record the information
    fix_info = {
        "certainty": certainty,
        "err_type": err_type,
        "fix_description": fix_description,
        "seen_before": False,
        "blamed_variable_correct": blamed_variable_correct,
        "variables_to_change": variables_to_change, # List of variable dicts
        "anything_missing": anything_missing,
        "missing_info": missing_info if anything_missing else None,
        "additional_notes": additional_notes if additional_notes else None,
    }

    return fix_info

def run_flux(directory_to_run_flux_in):
    """
    Run the Flux tool in the specified directory and capture its output.
    Returns the JSON output lines and the git commit hash.
    """
    original_cwd = Path.cwd()
    try:
        target_dir = Path(directory_to_run_flux_in).resolve()
        print(f"Changing directory to: {target_dir}")
        os.chdir(target_dir)

        # Get the current git commit hash
        commit_hash = None
        try:
            commit_hash_result = subprocess.run(
                ["git", "rev-parse", "--short", "HEAD"],
                check=True, capture_output=True, text=True, encoding='utf-8'
            )
            commit_hash = commit_hash_result.stdout.strip()
            print(f"Detected git commit hash: {commit_hash}")
        except FileNotFoundError:
             print("Warning: 'git' command not found. Cannot determine commit hash.", file=sys.stderr)
        except subprocess.CalledProcessError:
            print(f"Warning: Could not get git commit hash in {target_dir}. Is it a git repository?", file=sys.stderr)
        except Exception as e:
            print(f"Warning: Error getting git commit hash: {e}", file=sys.stderr)


        # Run the Flux command
        # Ensure environment variable is set correctly for the subprocess
        env = os.environ.copy()
        env["FLUX_DUMP_CONSTRAINT"] = "1"
        env["RUST_LOG"] = "info" # Or debug for more verbose flux/rustc logs

        command = ["cargo", "flux", "--message-format=json"]
        print(f"Running command: {' '.join(command)}")

        # Use PIPE for stdout, capture stderr separately
        result = subprocess.run(
            command,
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            encoding='utf-8', # Decode output directly
            errors='ignore' # Ignore decoding errors if any non-utf8 output
        )

        # Print stderr for debugging purposes
        if result.stderr:
             print("\n--- Flux stderr ---", file=sys.stderr)
             print(result.stderr, file=sys.stderr)
             print("--- End Flux stderr ---\n", file=sys.stderr)


        # Capture the output (stdout contains the JSON messages)
        json_output_lines = result.stdout.splitlines()
        print(f"Command finished. Captured {len(json_output_lines)} lines of JSON output.")

        return json_output_lines, commit_hash, target_dir

    finally:
        # Change back to the original directory
        os.chdir(original_cwd)
        print(f"Returned to directory: {original_cwd}")


# --- Summary Generation Logic (from make_summary.py) ---

def make_context_for_summary(commit_hash, flux_dir, data, flux_run_dir):
    """Generates code context string for the summary file."""
    ctx_str = ''
    original_cwd = Path.cwd()
    error_file_path_str = data['error'].get('file', 'N/A')
    # The error file path might be relative to flux_run_dir if ignore-file-prefix was used
    # Let's try to make it absolute based on flux_run_dir
    error_file_path = (Path(flux_run_dir) / error_file_path_str).resolve()


    try:
        print(f"  Generating context: Changing to {flux_dir}, checking out {commit_hash}")
        os.chdir(flux_dir)
        # Use --force if needed to discard local changes, but be cautious
        subprocess.run(["git", "checkout", commit_hash], check=True, capture_output=True, text=True)

        err_file_rel_path = Path(data['error']['file']) # Path relative to flux_dir root
        err_ctx_start = data['error']['function_context'].get('start')
        err_ctx_end = data['error']['function_context'].get('end')
        error_row = data['error'].get('row')

        ctx_str += f"Context File: {err_file_rel_path}\n"

        if err_ctx_start and err_ctx_end and err_file_rel_path.is_file():
            with open(err_file_rel_path, 'r') as ef:
                lines = ef.readlines()
                # Ensure line numbers are within bounds
                start = max(0, err_ctx_start - 1)
                end = min(len(lines), err_ctx_end)
                ctx_lines = lines[start:end]

                for i, line_content in enumerate(ctx_lines, start=err_ctx_start):
                    prefix = 'error>' if i == error_row else '      '
                    ctx_str += f"{i:4}: {prefix} {line_content.rstrip()}\n"
        else:
             ctx_str += f"  (Could not read context from {err_file_rel_path} at lines {err_ctx_start}-{err_ctx_end})\n"

    except FileNotFoundError:
         ctx_str += f"  (Context file not found at expected path: {err_file_rel_path} in commit {commit_hash})\n"
    except subprocess.CalledProcessError as e:
        ctx_str += f"  (Failed to checkout commit {commit_hash}: {e.stderr})\n"
    except Exception as e:
        ctx_str += f"  (An error occurred generating context: {e})\n"
    finally:
        try:
             # Attempt to switch back to a safer state, e.g., main or master branch
             subprocess.run(["git", "checkout", "-"], check=False, capture_output=True, text=True)
        except Exception:
             pass # Ignore errors during cleanup checkout
        os.chdir(original_cwd) # Change back CWD
        # print(f"  Context generation complete. Returned to {original_cwd}")


    return ctx_str


def generate_summary(output_directory, flux_run_dir=None):
    """
    Collects all processed errors from the output directory and generates
    summary.json and summary.txt files.
    """
    print("\n--- Generating Summary ---")
    summary_dict = {}
    num_errors_collected = 0
    all_error_data = []

    # Traverse through the output directory
    for root, dirs, files in os.walk(output_directory):
        # Skip the 'all_constraints' directory
        if Path(root).name == 'all_constraints':
            dirs[:] = [] # Don't recurse into this directory
            continue

        for file in files:
            if file == "error_and_fix.json":
                file_path = Path(root) / file
                try:
                    with open(file_path, 'r') as f:
                        data = json.load(f)
                    # Store the path relative to the output_directory for easier reference
                    data['summary_source_path'] = str(file_path.relative_to(output_directory))
                    all_error_data.append(data)
                    num_errors_collected += 1
                except json.JSONDecodeError as e:
                     print(f"Warning: Skipping corrupted JSON file: {file_path} ({e})", file=sys.stderr)
                except Exception as e:
                     print(f"Warning: Could not read or process file {file_path}: {e}", file=sys.stderr)


    if not all_error_data:
        print("No 'error_and_fix.json' files found to summarize.")
        return

    print(f"Collected {num_errors_collected} error reports.")

    # Group by commit hash (assuming directory structure output_dir/commit_hash/error_name)
    for data in all_error_data:
        if data['fix'].get('seen_before'):
            continue
        try:
            # Infer commit hash from the directory structure
            # output_dir / commit_hash / unique_name / error_and_fix.json
            parts = Path(data['summary_source_path']).parts
            if len(parts) >= 3:
                 commit_hash = parts[-3] # Should be the commit hash directory name
                 if commit_hash not in summary_dict:
                    summary_dict[commit_hash] = []
                 summary_dict[commit_hash].append(data)
            else:
                 # Fallback if structure is different (e.g., no commit hash folder)
                 unknown_commit_key = "unknown_commit"
                 if unknown_commit_key not in summary_dict:
                      summary_dict[unknown_commit_key] = []
                 summary_dict[unknown_commit_key].append(data)

        except Exception as e:
            print(f"Warning: Could not determine commit hash for {data.get('summary_source_path', 'N/A')}: {e}", file=sys.stderr)


    # --- Save summary.json ---
    summary_json_path = output_directory / "summary.json"
    try:
        with open(summary_json_path, 'w') as f:
            json.dump(summary_dict, f, indent=2)
        print(f"Saved JSON summary to {summary_json_path.resolve()}")
    except Exception as e:
        print(f"Error saving JSON summary: {e}", file=sys.stderr)


    # --- Save summary.txt ---
    summary_txt_path = output_directory / "summary.txt"
    try:
        with open(summary_txt_path, 'w', encoding='utf-8') as f:
            f.write(f"Flux Error Diagnostics Summary\n")
            f.write(f"Generated from: {output_directory.resolve()}\n")
            f.write(f"Total errors summarized: {num_errors_collected}\n")
            f.write("=" * 80 + "\n")

            for commit_hash, error_list in summary_dict.items():
                f.write(f"\n--- Commit: {commit_hash} ({len(error_list)} errors) ---\n")
                f.write("-" * 80 + "\n\n")

                for data in error_list:
                    error_info = data.get('error', {})
                    fix_info = data.get('fix', {})
                    func_ctx = error_info.get('function_context', {})

                    error_title = f"Error: {error_info.get('unique_name', 'N/A')}"
                    f.write(error_title + "\n")
                    f.write("~" * len(error_title) + "\n")
                    f.write(f"Location: {error_info.get('file', 'N/A')}:{error_info.get('row', 'N/A')}\n")
                    f.write("\n")

                    f.write("= Messages =\n")
                    f.write(f"{error_info.get('message1', 'N/A')}")
                    f.write(f"{error_info.get('message2', 'N/A')}")
                    if error_info.get('parsing_error'):
                         f.write(f"  * Parsing Warning: {error_info['parsing_error']}\n")
                    f.write("\n")

                    f.write("= Extracted Details =\n")
                    f.write(f" Predicate:         {error_info.get('predicate', 'N/A')}\n")
                    f.write(f" Blamed Variable:   {error_info.get('blamed_variable', 'N/A')}\n")
                    # Format related variables nicely
                    related_vars = error_info.get('related_variables', [])
                    if related_vars:
                         f.write(" Related Variables:\n")
                         for var in related_vars:
                            origin = var.get('origin', 'unknown')
                            # Strip quotes
                            if isinstance(origin, str) and origin.startswith('"') and origin.endswith('"'):
                                 origin = origin[1:-1]
                            f.write(f"  - {var.get('name', '?')} (depth {var.get('depth', '?')}, origin: {origin})\n")
                    else:
                        f.write(" Related Variables: None listed\n")
                    f.write("\n")


                    f.write("= User Feedback =\n")
                    f.write(f" Blamed Var Correct: {fix_info.get('blamed_variable_correct', 'N/A')}\n")
                    vars_to_change = fix_info.get('variables_to_change', [])
                    if vars_to_change:
                        f.write(" Variables to Change:\n")
                        for var in vars_to_change:
                             origin = var.get('origin', 'unknown')
                             if isinstance(origin, str) and origin.startswith('"') and origin.endswith('"'): origin = origin[1:-1]
                             f.write(f"  - {var.get('name', '?')} (depth {var.get('depth', '?')}, origin: {origin})\n")
                    else:
                        f.write(" Variables to Change: None selected\n")
                    f.write(f" Anything Missing:    {fix_info.get('anything_missing', 'N/A')}\n")
                    if fix_info.get('anything_missing'):
                        f.write(f"  -> Missing Info: {fix_info.get('missing_info', 'N/A')}\n")
                    f.write(f" Certainty:   {fix_info.get('certainty', 'N/A')}\n")
                    f.write(f" Fix Description:   {fix_info.get('fix_description', 'N/A')}\n")
                    f.write(f" Additional Notes:  {fix_info.get('additional_notes', 'N/A')}\n")
                    f.write("\n")

                    f.write("= Constraints & Context =\n")
                    constraints = func_ctx.get('constraint_files', [])
                    if constraints:
                        f.write(" Constraint Files:\n")
                        for cfile_path_str in constraints:
                            # Show path relative to the 'all_constraints' dir for brevity
                            try:
                                rel_path = Path(cfile_path_str).relative_to(output_directory / "all_constraints")
                                f.write(f"  - {rel_path}\n")
                            except ValueError:
                                f.write(f"  - {cfile_path_str}\n") # Fallback to full path
                    else:
                        f.write(" Constraint Files: None found\n")

                    # Add code context if flux_run_dir provided
                    if flux_run_dir and commit_hash != "unknown_commit":
                         context_text = make_context_for_summary(commit_hash, Path(flux_run_dir), data, flux_run_dir)
                         f.write("\n= Code Context =\n")
                         f.write(context_text)
                    elif flux_run_dir:
                         f.write("\n= Code Context =\n")
                         f.write("  (Skipped: Commit hash unknown)\n")


                    f.write("\n" + "-" * 60 + "\n\n") # Separator between errors

        print(f"Saved text summary to {summary_txt_path.resolve()}")
    except Exception as e:
        print(f"Error saving text summary: {e}", file=sys.stderr)

# --- Main Execution ---

if __name__ == "__main__":
    # Set up argument parser
    parser = argparse.ArgumentParser(
        description="Run Flux, parse new dual error messages, gather feedback, and generate summary.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    parser.add_argument("directory_to_run_flux_in",
                        help="Directory containing the Cargo project to run Flux on.")
    parser.add_argument("--output-directory", type=Path, default=DEFAULT_OUTPUT_DIR,
                        help="Directory to save diagnostic outputs and summary.")
    parser.add_argument("--log-directory", type=Path, default=None,
                        help="Directory where Flux dumps constraint logs (e.g., 'log' or 'target/flux'). "
                             f"Defaults to '<output-directory>/{DEFAULT_LOG_DIRECTORY}'.")
    parser.add_argument("--ignore-cache", action='store_true',
                        help="Ignore existing results and prompt for feedback again.")
    parser.add_argument("--ignore-file-prefix", type=str, default="",
                        help="File prefix to strip from Flux error messages (useful for subprojects/workspaces).")
    parser.add_argument("--flux-run-dir-for-summary", type=Path, default=None,
                        help="Path to the directory where Flux was originally run (needed by summary generator for code context via git checkout). "
                              "Defaults to the 'directory_to_run_flux_in' argument.")


    args = parser.parse_args()

    # Resolve directories
    flux_run_directory = Path(args.directory_to_run_flux_in).resolve()
    output_directory = Path(args.output_directory).resolve()

    # Default log directory relative to output directory if not specified
    log_directory = (Path(args.log_directory).resolve() if args.log_directory
                     else output_directory / DEFAULT_LOG_DIRECTORY)

    flux_run_dir_for_summary = (Path(args.flux_run_dir_for_summary).resolve() if args.flux_run_dir_for_summary
                                else flux_run_directory)


    print(f"Configuration:")
    print(f"  Flux Project Directory: {flux_run_directory}")
    print(f"  Output Directory:       {output_directory}")
    print(f"  Constraint Log Dir:   {log_directory}")
    print(f"  Summary Context Dir:  {flux_run_dir_for_summary}")
    print(f"  Ignore Cache:         {args.ignore_cache}")
    print(f"  Ignore File Prefix:   '{args.ignore_file_prefix}'")

    # Create the base output directory
    os.makedirs(output_directory, exist_ok=True)

    # Run Flux and capture the output
    json_output, commit_hash, actual_run_dir = run_flux(flux_run_directory)

    if commit_hash is None:
        print("Warning: No commit hash found. Output will be placed directly in the base output directory.", file=sys.stderr)
        # Use a placeholder if needed, or place directly in output_directory
        commit_hash_dir = output_directory / "no_commit"
    else:
        commit_hash_dir = output_directory / commit_hash

    # Make sure the specific directory for this commit exists
    os.makedirs(commit_hash_dir, exist_ok=True)
    print(f"Using output subdirectory: {commit_hash_dir}")

    # Also ensure the log directory exists for constraint finding/copying
    # Note: Flux might create this itself, but accessing it before then could fail.
    # The actual constraint logs are expected to be *created by* the flux run.
    # The log_directory arg tells *us* where to *look* for them afterwards.
    # Let's ensure our target for *copying* constraint files exists.
    os.makedirs(commit_hash_dir / "all_constraints", exist_ok=True)

    # Parse the JSON output
    print('parsing')
    parsed_errors = parse_flux_json(json_output, flux_run_directory, log_directory, commit_hash_dir, args.ignore_file_prefix)
    print(f"\nParsed {len(parsed_errors)} Flux error pairs.\n")

    # Save error and fix information
    processed_count = 0
    skipped_count = 0
    for error in parsed_errors:
        error_name = error["unique_name"]
        error_dir = commit_hash_dir / error_name
        error_file_path = error_dir / "error_and_fix.json"

        print(f"-- Processing Error: {error_name} --")

        # Check cache
        if not args.ignore_cache and error_file_path.exists():
            print(f"Skipping '{error_name}' because result file already exists: {error_file_path}")
            skipped_count += 1
            continue

        os.makedirs(error_dir, exist_ok=True)

        # Display error info to user
        print("\n=== Flux Error Output ===")
        print(error.get("raw1", "Primary message missing."))
        print("---")
        print(error.get("raw2", "Detail message missing."))
        if error.get('parsing_error'):
             print(f"*** Warning: {error['parsing_error']} ***")
        print("=========================")
        print(f"Predicate: {error.get('predicate', 'N/A')}")
        print(f"Blamed Variable: {error.get('blamed_variable', 'N/A')}")
        # Display related variables here too? Gather info asks, maybe redundant.

        # Render and display function context
        rendered_context = render_function_context(error)
        error["function_context"]["rendered_context"] = rendered_context # Save for potential future use
        print(rendered_context)

        # Gather feedback from user
        fix_info = gather_fix_info_from_user(error)

        # Save error and fix information to a JSON file
        error_and_fix_info = {
            "error": error,
            "fix": fix_info
        }
        try:
            with open(error_file_path, 'w') as f:
                json.dump(error_and_fix_info, f, indent=2)
        except Exception as e:
             print(f"Error saving diagnostic file {error_file_path}: {e}", file=sys.stderr)


        # Copy constraint files relevant to this error to the error directory
        copied_constraints_error_dir = []
        try:
            for constraint_path_str in error.get("function_context", {}).get("constraint_files", []):
                constraint_path = Path(constraint_path_str)
                if constraint_path.is_file():
                    dest_path = error_dir / constraint_path.name
                    shutil.copy(constraint_path, dest_path)
                    copied_constraints_error_dir.append(dest_path.name)
                else:
                     print(f"Warning: Constraint file listed but not found: {constraint_path_str}", file=sys.stderr)
        except Exception as e:
             print(f"Error copying constraint files to {error_dir}: {e}", file=sys.stderr)

        print(f"Saved error and fix information for '{error_name}' to {error_dir}")
        if copied_constraints_error_dir:
            print(f"  Copied constraints: {', '.join(copied_constraints_error_dir)}")
        processed_count += 1
        print("-" * 60)


    print(f"\nFinished processing errors.")
    print(f"  Processed new feedback for: {processed_count} errors.")
    print(f"  Skipped cached results for: {skipped_count} errors.")

    # Generate the summary files
    generate_summary(output_directory, flux_run_dir_for_summary)

    print("\nScript finished.")
