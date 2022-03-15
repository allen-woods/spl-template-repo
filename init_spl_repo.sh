# Define our APACHE parser.
function init_apache_license {
  if [ "${1}" = "" ] || [ "${2}" = "" ]; then
    printf '%s\n' \
    "error: you must pass a legal first and last name as arguments." \
    "-----" \
    "usage: ./init_apache_license.sh <First> <Last>"
    return 1
  fi

  local copyright_holder="${1} ${2}"
  local copyright_year=$( date "+%Y" )

  curl \
    --silent \
    -X GET \
    -H 'Content-Type: text/html' \
    https://www.apache.org/licenses/LICENSE-2.0.txt | \
    while IFS= read -r line; do
      local margin=$(
        echo "${line}" | \
        sed 's|^\([\ ]\{1,\}\).*$|\1|'
      )

      local copyright=$(
        echo "${line}" | \
        sed "s|^[\ ]\{${#margin}\}\([Copyright]\{9\}\).*$|\1|"
      )
      if [ "${copyright}" = "Copyright" ]; then
        echo "${margin}${copyright} ${copyright_year} ${copyright_holder}" >> LICENSE-APACHE
      else
        echo "${line}" >> LICENSE-APACHE
      fi
    done
}

# Define our MIT parser.
function init_mit_license {
  if [ "${1}" = "" ] || [ "${2}" = "" ]; then
    printf '%s\n' \
    "error: you must pass a legal first and last name as arguments." \
    "-----" \
    "usage: ./init_mit_license.sh <First> <Last>"
    return 1
  fi

  local copyright_holder="${1} ${2}"
  local copyright_year=$( date "+%Y" )

  local parse_license_to_file="false"

  curl \
    --silent \
    -X GET \
    -H 'Content-Type: text/html' \
    https://opensource.org/licenses/MIT | \
    while IFS= read -r line; do
      local chk_start='<div id="LicenseText">'
      local chk_end='<div id="EndLicenseText">'
      local parsed_line=$( echo ${line} | tr -d '\n' | head -n 1 )

      if [ "${parsed_line}" = "${chk_start}" ]; then
        if [ "${parse_license_to_file}" = "false" ]; then
          parse_license_to_file="true"
        fi
      elif [ "${parsed_line}" = "${chk_end}" ]; then
        if [ "${parse_license_to_file}" = "true" ]; then
          parse_license_to_file="false"
        fi
      fi

      if [ "${parse_license_to_file}" = "true" ]; then
        local copyright=$(
          echo "${line}" | \
          sed "s|.*\([Copyright]\{9\}\).*$|\1|"
        )

        if [ "${copyright}" = "Copyright" ]; then
          echo "${copyright} ${copyright_year} ${copyright_holder}" >> LICENSE-MIT
        else
          if [ "${line}" != "${chk_start}" ]; then
            if [ "${line}" != "${chk_end}" ]; then
              echo "${line}" | sed 's|<[/]\{0,1\}p>||g; s|<[/]\{0,1\}div>||g;' >> LICENSE-MIT
            fi
          fi
        fi
      fi
    done
}

# Define our README.md generator
function init_spl_readme {
  if [ -f "LICENSE-APACHE" ] && [ -f "LICENSE-MIT" ]; then
    if [ -f "README.md" ]; then
      rm -f README.md
    fi

    printf '%s\n' \
      "## License" \
      "" \
      "Licensed under either of" \
      "" \
      "- Apache License, Version 2.0, ([LICENSE_APACHE](LICENSE-APACHE) or https://www.apache.org/licenses/LICENSE-2.0)" \
      "- MIT License ([LICENSE-MIT](LICENSE-MIT) or https://opensource.org/licenses/MIT)" \
      "" \
      "at your option." > README.md

  else
    echo "error: something went wrong while generating licenses!"
    return 1
  fi
}

function add_commit_push_spl_repo_init {
  git add LICENSE-APACHE LICENSE-MIT README.md
  git commit -m "Added licenses and updated readme."
  git push --set-upstream origin $( git config --get init.defaultBranch )
}

function init_spl_repo {
  init_apache_license $@
  init_mit_license $@
  init_spl_readme
  [ $? -eq 0 ] && add_commit_push_spl_repo_init
}

init_spl_repo $@
