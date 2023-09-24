{
  pkgs,
  colorscheme,
  ...
}: {
  home.packages = with pkgs; [deadd-notification-center];
  home.file.".config/deadd/deadd.css".source = colorscheme.deadd-css-file;
  systemd.user.services.deadd-notification-center = {
    Unit = {
      Description = "Deadd Notification Center";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      # We need locale from glibc (and to inherit the $PATH)
      # See https://github.com/phuhl/linux_notification_center/issues/63
      ExecStart = "${pkgs.runtimeShell} -l -c ${pkgs.deadd-notification-center}/bin/deadd-notification-center";
      Restart = "always";
      RestartSec = "1sec";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
