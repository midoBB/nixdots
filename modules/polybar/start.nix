{pkgs, ...}: let
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
  grep = "${pkgs.gnugrep}/bin/grep";
  wc = "${pkgs.coreutils}/bin/wc";
  cut = "${pkgs.coreutils}/bin/cut";
in
  pkgs.writeShellScriptBin "starter" ''
    polybar-msg cmd quit
    count=$(${xrandr} --query | ${grep} " connected" | ${cut} -d" " -f1 | ${wc} -l)
    if [ "$count" = 1 ]; then
      m=$(${xrandr} --query | ${grep} " connected" | ${cut} -d" " -f1)
      MONITOR=$m polybar  mainbar & disown
    else
      for m in $(${xrandr} --query | ${grep} " connected" | ${cut} -d" " -f1); do
        MONITOR=$m polybar mainbar & disown
      done
    fi
  ''
