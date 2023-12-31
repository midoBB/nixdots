{
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        # disabledTrayIcon = true;
        showStartupLaunchMessage = false;
        showDesktopNotification = false;
      };
    };
  };
}
