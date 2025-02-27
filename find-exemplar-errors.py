import json
import os
from pathlib import Path
from collections import defaultdict

EXEMPLARS = [ {'condition': 1, 'reason': 'a'},
              {'condition': 1, 'reason': 'b'},
              {'condition': 2, 'reason': 'a'},
              {'condition': 2, 'reason': 'b'} ]

def err_type_to_str(err_type):
    return f'{err_type["condition"]}{err_type["reason"]}'

def find_exemplar_errors(base_directory):
    exemplar_errors = defaultdict(list)
    exemplar_names  = defaultdict(list)
    for root, dirs, files in os.walk(base_directory):
        for file in files:
            if file == 'summary.json':
                file_path = (Path(root) / file).resolve()
                with open(file_path, 'r') as f:
                    data = json.load(f)
                for _, errors in data.items():
                    for error in errors:
                        err_type = error.get('fix', {}).get('error_type', {})
                        if err_type in EXEMPLARS:
                            err_name = error.get('error', {}).get('unique_name', 'N/A')
                            exemplar_names[err_type_to_str(err_type)].append(err_name)
                            constraint_files = error.get('error', {}).get('function_context', {}).get('constraint_files', [])
                            files = [ file for file in constraint_files if file.endswith('.fluxc') and '.simp' not in file ]
                            for file in files:
                                with open(file) as f:
                                    length = len(f.readlines())
                                    if length == 1:
                                        continue
                                    exemplar_errors[err_type_to_str(err_type)].append((length, file, err_name))
    return exemplar_errors, exemplar_names

if __name__ == '__main__':
    exemplar_errors, exemplar_names = find_exemplar_errors('.')
    # for exemplar_type, errors in exemplar_errors.items():
    #     print('Type', exemplar_type)
    #     for (length, file, error_name) in sorted(errors):
    #         print(file, length, error_name)
    #     print()
    for exemplar_type, names in exemplar_names.items():
        print('Type', exemplar_type, 'num errors', len(names))
        for name in names:
            print(' ', name)
