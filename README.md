# System Programming Language Template Repo

When developing a project that uses a system programming language (SPL), it is common practice to provide both an Apache 2.0 license and an MIT license on an open-source repository.

Currently, there is no facility for adding multiple licenses to a repository using GitHub's `gh` CLI utility.

This repository is an example of how we can use the `--template` flag provided by `gh` in combination with shell script to achieve the desired result.

## Compatible Languages

As of the date of the latest commit to this repo, the appropriate languages to use with this template repository are as follows:

### Supported SPLs

| Language | Gitignore String |
| :------- | :--------------- |
| Ada      | "Ada"            |
| C        | "C"              |
| C++      | "C++"            |
| D        | "D"              |
| Go       | "Go"             |
| Nim      | "Nim"            |
| Rust     | "Rust"           |
| Swift    | "Swift"          |

Source: [System programming language](https://en.wikipedia.org/wiki/System_programming_language) - Wikipedia

## Basic Installation

At minimum, run the following locally from your work $PATH:

```shell
# Simple setup.

gh repo create <new_repo_name> \
  --clone
  --template "allen-woods/spl-template-repo"
```

Once the repository has been cloned locally, `cd` into it and run the script:

```shell
# You must pass your first and last name as arguments.

./init_spl_repo.sh <First> <Last>
```

This script will automatically perform the following steps:

1. Request the Apache-2.0 license as plaintext via `curl`.
2. Parse the following data into the Apache-2.0 license:
   - Your first name
   - Your last name
   - The current year via `date`
3. Request the MIT license as plaintext via `curl`.
4. Parse the same information from step 2 into the MIT license.
5. Trigger a replacement of this README file in favor of a new one containing the standard **License** clause.
6. Add, commit, and push generated files using the `--set-upstream` flag.

## Next Steps

From here, you can:

- Delete `init_spl_repo.sh` from your local repo directory.
- Add information relevant to your project above the **License** header in the README.

## Advanced Installation

GitHub provides `.gitignore` templates for many SPLs, but the `gh` CLI utility currently does not allow mixed use of both the `--gitignore` and `--template` flags.

To enable the `.gitignore` template for the supported languages in [Table 1.1](#supported-spls) above, we can simply provide the language name as the optional third argument to the init script, as follows:

```shell
# Consult table 1.1 for supported SPLs.

gh repo create <new_repo_name> \
  --clone \
  --description="Your description here." \
  --public \
  --template "allen-woods/spl-template-repo"

cd <new_repo_name>

./init_spl_repo.sh <First> <Last> <spl>
```
