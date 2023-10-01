{
  pkgs-unstable,
  pkgs,
  ...
}: let
  valeinit.sh = pkgs.writeScriptBin "valeinit" ''
    #!/usr/bin/env bash

    # Define the configuration content
          CONFIG_CONTENT="
          StylesPath = styles

          MinAlertLevel = suggestion

          Packages = Microsoft, proselint, write-good, alex, Readability, Joblint

          [*]
          BasedOnStyles = Vale, Microsoft, proselint, write-good, alex, Readability, Joblint
          "

    # Determine the root directory of the Git project
          GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

    # Check if we are in a Git repository
          if [ -z "$GIT_ROOT" ]; then
            echo "Not in a Git repository. Please navigate to a Git project directory."
            exit 1
          fi

    # Check if .vale.ini already exists and create it if not
          if [ ! -f "$GIT_ROOT/.vale.ini" ]; then
            echo "$CONFIG_CONTENT" > "$GIT_ROOT/.vale.ini"
          else
            echo ".vale.ini already exists. Please remove or edit it manually."
            exit 1
          fi
    # Add 'styles' to .gitignore if not already present
          if [ ! -f "$GIT_ROOT/.gitignore" ]; then
            echo "/styles" > "$GIT_ROOT/.gitignore"
            echo ".gitignore created and 'styles' added to it."
          elif ! grep -q '/styles$' "$GIT_ROOT/.gitignore"; then
            echo "/styles" >> "$GIT_ROOT/.gitignore"
            echo "Added 'styles' to .gitignore."
          fi
    # Run the 'vale sync' command
          vale sync

          echo "Configuration copied to .vale.ini and 'vale sync' command executed."
  '';
in {
  home.packages = [
    valeinit.sh
    pkgs-unstable.vale
  ];
}
