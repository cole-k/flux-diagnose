import json
import argparse
from collections import defaultdict

def parse_summary(filepath):
    """Loads the summary JSON data from the given file path."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
        return data
    except FileNotFoundError:
        print(f"Error: File not found at {filepath}")
        return None
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from {filepath}")
        return None
    except Exception as e:
        print(f"An unexpected error occurred loading the file: {e}")
        return None

def process_errors(summary_data):
    """
    Filters and processes error entries from the summary data based on criteria.
    Returns a list of dictionaries, each representing a row for the table.
    """
    results = []
    # The top level keys are commit hashes (or similar identifiers)
    for commit_hash, error_list in summary_data.items():
        if not isinstance(error_list, list):
            # Assuming the structure is {commit: [errors...]}
            # If not, skip this entry.
            print(f"Warning: Skipping entry for '{commit_hash}' - expected a list of errors, got {type(error_list)}.")
            continue

        for entry in error_list:
            # Ensure both 'error' and 'fix' sub-objects exist
            fix_info = entry.get('fix')
            error_info = entry.get('error')

            if not fix_info or not error_info:
                # Skip entries missing essential information
                continue

            # --- Apply Filtering Criteria ---
            # 1. Ignore if seen_before is True
            if fix_info.get('seen_before') is True:
                continue

            # 2. Ignore if certainty is False
            if fix_info.get('certainty') is False:
                continue
            # We also implicitly ignore if certainty is missing, assuming False is the default for uncertainty

            # --- Extract Data for Table ---
            try:
                name = error_info.get('unique_name', 'N/A')
                err_type = fix_info.get('err_type', 'N/A')

                related_vars = error_info.get('related_variables', [])
                # Ensure related_vars is actually a list before taking len
                num_vars = len(related_vars) if isinstance(related_vars, list) else 0

                # Handle potential missing key for blamed_variable_correct
                # Default to 'Unknown' if missing, although the filters should imply its presence
                correct_val = fix_info.get('blamed_variable_correct')
                if correct_val is None:
                    correct_str = 'Unknown'
                else:
                    # Explicitly convert boolean to Yes/No for clarity in table
                    correct_str = 'Yes' if correct_val else 'No'

                results.append({
                    'name': name,
                    'type': err_type,
                    'num_vars': num_vars,
                    'correct': correct_str
                })
            except Exception as e:
                # Catch potential errors during data extraction for a specific entry
                print(f"Warning: Error processing entry under commit '{commit_hash}': {e}. Entry data: {entry}")
                continue

    return results

def print_table(results):
    """Prints the processed results as a formatted text table."""
    if not results:
        print("No data to display after filtering.")
        return

    headers = ["Error Name", "Error Type", "# Related Vars", "Blamed Var Correct?"]

    # Calculate maximum width for each column based on headers and data
    # Initialize with header lengths
    col_widths = {header: len(header) for header in headers}

    # Update widths based on data, converting data to string for length check
    for row in results:
        col_widths["Error Name"] = max(col_widths["Error Name"], len(str(row['name'])))
        col_widths["Error Type"] = max(col_widths["Error Type"], len(str(row['type'])))
        col_widths["# Related Vars"] = max(col_widths["# Related Vars"], len(str(row['num_vars'])))
        col_widths["Blamed Var Correct?"] = max(col_widths["Blamed Var Correct?"], len(str(row['correct'])))

    # Create format strings for header and rows
    # Using left-alignment for name/type/correct, right-alignment for number
    header_fmt = (
        f"{{:<{col_widths['Error Name']}}}  "
        f"{{:<{col_widths['Error Type']}}}  "
        f"{{:>{col_widths['# Related Vars']}}}  " # Right align number
        f"{{:<{col_widths['Blamed Var Correct?']}}}"
    )
    row_fmt = (
        f"{{name:<{col_widths['Error Name']}}}  "
        f"{{type:<{col_widths['Error Type']}}}  "
        f"{{num_vars:>{col_widths['# Related Vars']}}}  " # Right align number
        f"{{correct:<{col_widths['Blamed Var Correct?']}}}"
    )

    # Print the header
    print(header_fmt.format(*headers))

    # Print the separator line
    separator = "-".join("-" * col_widths[h] for h in headers) + "-" * (len(headers) -1) * 2
    print("-" * len(header_fmt.format(*headers))) # Dynamic separator length


    # Print the data rows
    for row in results:
        print(row_fmt.format(**row))

def main():
    """Main function to parse arguments and run the processing."""
    parser = argparse.ArgumentParser(
        description="Parse a flux-diagnose summary.json file and output a filtered table.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
        )
    parser.add_argument("summary_file", help="Path to the summary.json file.")
    args = parser.parse_args()

    summary_data = parse_summary(args.summary_file)

    if summary_data:
        processed_results = process_errors(summary_data)
        print_table(processed_results)

if __name__ == "__main__":
    main()

