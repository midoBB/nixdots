{ pkgs, ... }:
let
  xdo = "${pkgs.xdotool}/bin/xdotool";
  xpo = "${pkgs.xorg.xprop}/bin/xprop";
  awk = "${pkgs.gawk}/bin/awk";
  tail = "${pkgs.coreutils}/bin/tail";

in pkgs.writeShellScriptBin "wmclasser" ''
  echo $(${xpo} -id $(${xdo} getwindowfocus) WM_CLASS | ${awk} -F\" '{if ($2=="org.wezfurlong.wezterm") print "Terminal";
  else print $2}' | ${awk} '{print toupper(substr($1,1,1)) tolower(substr($1,2))}' | ${tail} -n1)
''
