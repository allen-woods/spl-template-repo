# System Programming Language Template Repo

When developing a project that uses a system programming language, it is common practice to provide both an Apache 2.0 license and an MIT license on an open-source repository.

Currently, there is no facility for adding multiple licenses to a repository using GitHub's `gh` CLI utility.

This repository is an example of how we can use the `--template` flag provided by `gh` in combination with shell script to achieve the desired result.

## Compatible Languages

As of the date of the latest commit to this repo, the appropriate languages to use with this template repository are as follows:

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

From here, you can freely edit the generated README to contain relevant information about your project above the **License** header.

## Advanced Installation

To supply a `gitignore` template using the `--gitignore` flag:

```shell
# Example Go project for reference only, consult table above for supported languages.

gh repo create example-go-project \
  --clone \
  --description="A project written in Go." \
  --gitignore="Go" \
  --public \
  --template "allen-woods/spl-template-repo"
```
