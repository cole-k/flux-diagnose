# Usage

Runs Flux on a project and interactively prompts the user to identify where the errors actually are.

# General process

1. Check out a commit of a repository that I'm using the tool on.
2. Run flux on the repository.
  ```
  FLUX_DUMP_CONSTRAINT=1 cargo flux --message-format=json 2>/dev/null
  ```
3. Parse the output into individual errors.
4. Do some basic identification of relevant parts of the code from the error message.
5. Present me the errors and let me identify the parts of the code they correspond to. Then I will have the option to indicate what is wrong (if anything) with the error message.
6. Store the results somewhere on disk.

# Interesting errors

- ringbuffer-diagnostics/a41e71dec (nontrivial fix)

# Notes

Written at least partially using GPT-4o-mini.
