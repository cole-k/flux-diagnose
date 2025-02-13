import json
import os
import sys
from pathlib import Path
import subprocess

"""
make_summary.py

This script collects unsolved errors from a specified output directory generated by the Flux tool.
It creates a summary of errors that have not been seen before and saves the results in two formats:
- summary.json: A JSON file mapping commit hashes to lists of error objects.
- summary.txt: A text file containing detailed information about each error, including the error message, constraint files, and fix information.

Usage:
    python make_summary.py <output_directory> [<flux_directory>]

Arguments:
    <output_directory>   The path to the directory containing error_and_fix.json files.
    [<flux_directory>]   (Optional) The path to the directory where Flux was run. If provided, the script will include context from the original files for each error.

Example:
    python make_summary.py /path/to/output/directory /path/to/flux/directory
"""

def collect_unsolved_errors(base_directory):
    summary_dict = {}
    num_errors = 0

    # Traverse through the base directory
    for root, dirs, files in os.walk(base_directory):
        for file in files:
            if file == "error_and_fix.json":
                file_path = Path(root) / file
                with open(file_path, 'r') as f:
                    data = json.load(f)

                # Check if "fix" exists and if "seen_before" is False
                if "fix" in data and not data["fix"].get("seen_before", False):
                    commit_hash = Path(root).parent.name  # Get the commit hash from the directory structure
                    if commit_hash not in summary_dict:
                        summary_dict[commit_hash] = []
                    summary_dict[commit_hash].append(data)
                    num_errors += 1
    print(f"Collected {num_errors} unique errors")
    return summary_dict

def write_context(commit_hash, flux_dir, data, f):
    # Change to the Flux directory
    try:
        os.chdir(flux_dir)  # Change to the Flux directory
        # Checkout the specified commit hash
        subprocess.run(["git", "checkout", commit_hash], check=True, capture_output=True, text=True)

        # Print the context of the error
        err_file = data['error']['file']
        fix_line = data['fix']['fix_line']
        err_ctx_start = data['error']['function_context']['start']
        err_ctx_end = data['error']['function_context']['end']
        ctx_start = min(fix_line, err_ctx_start)
        ctx_end = max(fix_line, err_ctx_end)

        f.write(err_file + "\n")
        with open(err_file, 'r') as ef:
            lines = ef.readlines()
            # Print the lines in the context as well as the line numbers, ensuring that the line numbers are aligned
            for i in range(ctx_start, ctx_end + 1):
                f.write(f"{i:3}: {'error>' if i == data['error']['row'] else '      '} {'fix> ' if i == data['fix']['fix_line'] else '     '}{lines[i - 1].rstrip()}\n")

    except Exception as e:
        print(f"An error occurred while processing the commit: {e}")
    finally:
        # Optionally, you can reset the git state if needed
        subprocess.run(["git", "checkout", "-"], capture_output=True, text=True)

def save_summary(base_directory, summary_dict, flux_dir=None):
    # Save summary.json
    summary_json_path = Path(base_directory) / "summary.json"
    with open(summary_json_path, 'w') as f:
        json.dump(summary_dict, f, indent=4)
    print(f"Saved summary to {summary_json_path}")

    # Save summary.txt
    summary_txt_path = Path(base_directory) / "summary.txt"
    with open(summary_txt_path, 'w') as f:
        for commit_hash, error_fix_obj in summary_dict.items():
            f.write("-" * 80 + "\n")
            f.write(f"Commit Hash: {commit_hash}\n")
            f.write("-" * 80 + "\n")
            for data in error_fix_obj:
                error_title = f"ERROR: {data['error']['unique_name']}"
                f.write("=" * len(error_title) + "\n")
                f.write(error_title + "\n")
                f.write("=" * len(error_title) + "\n")
                f.write(f"Error Message: {data['error']['raw']}\n")
                # If flux_dir is provided, print the context
                if flux_dir:
                    write_context(commit_hash, flux_dir, data, f)
                    f.write("\n")

                rendered_constraint_files = "\n".join([f"  {file}" for file in data['error']['function_context']['constraint_files']])
                f.write(f"Constraint files:\n{rendered_constraint_files}\n")
                f.write("Fix Information:\n")
                
                # Format the fix information
                fix_info = data.get("fix", {})
                f.write(f"  Fix Line: {fix_info.get('fix_line', 'N/A')}\n")
                f.write(f"  Helpful Message: {fix_info.get('helpful_message', 'N/A')}\n")
                f.write(f"  Problem Description: {fix_info.get('problem_description', 'N/A')}\n")
                f.write(f"  Fix Type: {fix_info.get('fix_description', {}).get('fix_type', 'N/A')}\n")
                f.write(f"  Fix Description: {fix_info.get('fix_description', {}).get('description', 'N/A')}\n")
                f.write(f"  Certainty: {fix_info.get('certainty', False)}\n")
                f.write("\n")

    print(f"Saved summary to {summary_txt_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python make_summary.py <output_directory> [<flux_directory>]")
        sys.exit(1)

    output_directory = sys.argv[1]
    flux_directory = sys.argv[2] if len(sys.argv) > 2 else None
    summary_dict = collect_unsolved_errors(output_directory)
    save_summary(output_directory, summary_dict, flux_directory) 