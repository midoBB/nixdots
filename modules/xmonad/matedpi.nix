{pkgs, ...}: let
  matedpi = pkgs.writeScriptBin "matedpi" ''
    #!/usr/bin/env bash
    # Open mate-appearance-properties
    mate-appearance-properties &

    # Wait for the window to appear
    window_name="Appearance Preferences"
    echo "Waiting for '$window_name' window to appear..."
    while ! xdotool search --name "$window_name" > /dev/null 2>&1; do
        sleep 1
    done

    # Get the window ID
    window_id=$(xdotool search --name "$window_name")

    # Kill the program
    echo "Killing '$window_name'..."
    xdotool windowkill "$window_id"
  '';
in {
  home.packages = [matedpi pkgs.xdotool];
}
