{pkgs, ...}: {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    package = pkgs.picom-next;
    # Transparency/Opacity
    inactiveOpacity = 0.95;
    activeOpacity = 1.0;
    opacityRules = [
      "100:class_g   *?= 'firefox'"
      "100:class_g   *?= 'Deadd-notification-center'"
      "100:class_g   *?= 'Rofi'"
      "95:class_g = 'org.wezfurlong.wezterm' && focused"
      "90:class_g = 'org.wezfurlong.wezterm' && !focused"
    ];

    # Fading
    fade = true;
    fadeDelta = 10;

    settings = {
      animations = true;
      animation-stiffness-in-tag = 125;
      animation-stiffness-tag-change = 90.0;
      animation-window-mass = 0.4;
      animation-dampening = 15;
      animation-clamping = true;

      # Shadows
      shadow = true;
      shadow-radius = 17;
      shadow-opacity = 1;
      shadow-offset-x = -13;
      shadow-offset-y = -13;
      shadowExclude = [
        "class_g = 'eww-topbar-btw'"
        "name = 'Notification'"
        "_GTK_FRAME_EXTENTS@:c"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      ];
      focus-exclude = [
        "class_g = 'mpv'"
      ];
      blur-background-exclude = [
        "window_type = 'desktop'"
        "class_g = 'Polybar'"
        "class_g = 'discord-overlay'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      detect-transient = true;
      mark-wmwin-focused = true;
      #open windows
      animation-for-open-window = "zoom";
      #minimize or close windows
      animation-for-unmap-window = "squeeze";
      animation-for-transient-window = "slide-up"; #available options: slide-up, slide-down, slide-left, slide-right, squeeze, squeeze-bottom, zoom

      #set animation for windows being transitioned out while changings tags
      animation-for-prev-tag = "minimize";
      #enables fading for windows being transitioned out while changings tags
      enable-fading-prev-tag = true;

      #set animation for windows being transitioned in while changings tags
      animation-for-next-tag = "slide-in-center";
      #enables fading for windows being transitioned in while changings tags
      enable-fading-next-tag = true;
      # Blur
      blur-method = "dual_kawase";
      blur-strength = 8;
      blur-backgroud-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
        "class_g = 'Polybar'"
      ];
      popup_menu = {
        opacity = 1.0;
        shadow = false;
        full-shadow = false;
        focus = false;
      };
      # Radius
      corner-radius = 10;
      round-borders = 1;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
        "class_g = 'Polybar'"
      ];
    };
  };
}
