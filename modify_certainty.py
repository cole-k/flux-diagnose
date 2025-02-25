import json
import os
from pathlib import Path

def update_certainty_values(base_directory):
    # Traverse through the base directory
    for root, dirs, files in os.walk(base_directory):
        for file in files:
            if file == "error_and_fix.json":
                file_path = Path(root) / file
                with open(file_path, 'r') as f:
                    data = json.load(f)

                # Check if "fix" exists in the data
                if "fix" in data:
                    # Update the certainty value
                    certainty_value = data["fix"].get("certainty", "")
                    if type(certainty_value) == str:
                        data["fix"]["certainty"] = certainty_value.startswith("y")
                    # hard code as false if not present
                    if "seen_before" not in data["fix"]:
                        print("WARN: hardcoding seen_before to false becuase not present")
                        data["fix"]["seen_before"] = False
                    else:
                        data["fix"]["seen_before"] = data["fix"]["seen_before"].startswith("y")

                # Save the modified data back to the JSON file
                with open(file_path, 'w') as f:
                    json.dump(data, f, indent=4)

                print(f"Updated certainty in {file_path}")

if __name__ == "__main__":
    # Specify the base directory where the error_and_fix.json files are located
    base_directory = input("Enter the base directory path: ")
    update_certainty_values(base_directory) 