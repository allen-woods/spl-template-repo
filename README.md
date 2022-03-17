# System Programming Language Template Repo

When developing a project that uses a system programming language (SPL), it is common practice to provide both an Apache 2.0 license and an MIT license on an open-source repository.

Currently, there is no facility for adding multiple licenses to a repository using GitHub's `gh` CLI utility.

This repository is an example of how we can use the `--template` flag provided by `gh` in combination with shell script to achieve the desired result.

## Compatible Languages

As of the date of the latest commit to this repo, the appropriate languages to use with this template repository are as follows:

### Supported SPLs

| Language | Gitignore String | SPL args                        |
| :------- | :--------------- | :------------------------------ |
| Ada      | "Ada"            | "ada"                           |
| C        | "C"              | "c"                             |
| C++      | "C++"            | "c++"<br>"cpp"<br>"cxx"<br>"cc" |
| D        | "D"              | "d"                             |
| Go       | "Go"             | "go"<br>"golang"                |
| Nim      | "Nim"            | "nim"                           |
| Rust     | "Rust"           | "rust"<br>"rs"                  |
| Swift    | "Swift"          | "swift"<br>"sw"                 |

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
chmod +x ./init_spl_repo.sh
./init_spl_repo.sh
```

You will be presented with a usage message detailing how to run the script successfully&mdash;see [here](#sample-script-usage-message) for an example.

### Example SPL Project Script Flags

```shell
./init_spl_repo.sh \
  --license-type="apache,mit" \
  --license-holder="Your Name"
```

### Script Outline

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

### Next Steps

From here, you can:

- Delete `init_spl_repo.sh` from your local repo directory.
- Add information relevant to your project above the **License** header in the README.

## Advanced Installation

GitHub provides `.gitignore` templates for many SPLs, but the `gh` CLI utility currently does not allow mixed use of both the `--gitignore` and `--template` flags.

To enable the `.gitignore` template for the supported languages in [Table 1.1](#supported-spls) above, we can simply provide the gitignore type via the optional `--gitignore` flag, as follows:

```shell
# Consult table 1.1 for supported SPLs.

gh repo create <new_repo_name> \
  --clone \
  --description="Your description here." \
  --public \
  --template "allen-woods/spl-template-repo"

cd <new_repo_name>

./init_spl_repo.sh \
  --license-type="apache,mit" \
  --license-holder="Your Name" \
  --gitignore="rs" # Let's use Rust!
```

## Sample Script Usage Message

```shell
Usage:  ./init_spl_repo.sh \
        --license-type="comma,separated,list" \
        --license-holder="Holder's Name" [\]
        [--gitignore="SPL"]

Available License / License Header Types:

        agpl3
        agpl3-header
        apache
        apache-header
        bsd2
        bsd3
        cc0
        cc0-header
        cc_by
        cc_by-header
        cc_by_nc
        cc_by_nc-header
        cc_by_nc_nd
        cc_by_nc_nd-header
        cc_by_nc_sa
        cc_by_nc_sa-header
        cc_by_nd
        cc_by_nd-header
        cc_by_sa
        cc_by_sa-header
        cddl
        epl
        gpl2
        gpl3
        gpl3-header
        isc
        lgpl
        mit
        mpl
        mpl-header
        unlicense
        wtfpl
        wtfpl-header
        wtfpl-header-warranty
        x11
        zlib

Option: ./init_spl_repo.sh \
        ... [\]
        [--gitignore="SPL"]

Gitignore Support for System Programming Languages (SPLs) - Optional

        Ada
        C
        C++
        D
        Go
        Nim
        Rust
        Swift
```
