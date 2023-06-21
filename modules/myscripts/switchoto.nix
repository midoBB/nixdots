{ pkgs, ... }:

let
  switchto = pkgs.writeScriptBin "switchto" ''
    #!/usr/bin/env bash
    runcmd="$1"
    wmclass="$2"
    function switch() {
        ${pkgs.wmctrl}/bin/wmctrl -xa "$wmclass"
    }
    if ! switch; then
        eval "$runcmd" &
        while ! switch; do sleep 0.1; done
    fi
  '';
in { home.packages = [ switchto ]; }
