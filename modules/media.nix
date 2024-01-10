# vim:foldmethod=marker
{
  pkgs,
  workMode,
  ...
}: {
  # MPV {{{
  programs.mpv = {
    enable = true;
    config = {
      save-position-on-quit = "yes";
      volume = 90;
      blend-subtitles = "yes";
      screenshot-directory = "~/Pictures/Screenshots";
      screenshot-format = "png";
      osd-bar = "no";
      border = "no";
      osc = "no";
      hwdec = "auto";
      vo = "gpu";
      profile = "gpu-hq";
      alang = "en";
      keep-open = "yes";
      keepaspect-window = "no";
      slang = "eng,en,en-en,en-orig,en-en-nP7-2PuUl7o,fra,fre,fr,fr-en,fr-it,fr-en-nP7-2PuUl7o";
      sub-font = "Arial Regular";
      sub-border-size = 1;
      sub-color = "#CDCDCD";
      sub-shadow = 3;
      sub-shadow-color = "#000000";
      sub-shadow-offset = 2;
    };
    bindings = {
      WHEEL_RIGHT = "seek  5 exact";
      WHEEL_LEFT = "seek  -5 exact";
      RIGHT = "seek  5 exact";
      LEFT = "seek -5 exact";
      UP = "seek  30 exact";
      DOWN = "seek -30 exact";
      WHEEL_UP = "add volume 5";
      WHEEL_DOWN = "add volume -5";
    };
    scripts = [pkgs.mpvScripts.autoload pkgs.mpvScripts.mpris];
  };
  #mpv scripts not in the repos

  xdg.configFile = with pkgs; {
    "mpv/scripts/thumbfast.lua".source =
      pkgs.fetchFromGitHub {
        owner = "po5";
        repo = "thumbfast";
        rev = "ddc61957ce38b62283c5d7ef99a7252c7499cc8b";
        sha256 = "1/QB1WZ+zY22PeGMsoJh+dELUBJfXGa1Wu9PojF1ym4=";
      }
      + "/thumbfast.lua";
    "mpv/scripts/uosc.lua".source =
      fetchFromGitHub {
        owner = "tomasklaen";
        repo = "uosc";
        rev = "1ed8a7a823ce05df11cd46f09a295fae05dca0d2";
        sha256 = "TdOWG6hrPoU6nnWqsd0Uxjd/7hSJlIg0o3OIOhXfRsY=";
      }
      + "/scripts/uosc.lua";

    "mpv/script-opts/uosc.conf" = {
      text = ''
        top_bar_controls=no
      '';
    };

    "mpv/scripts/uosc_shared" = {
      recursive = true;
      source =
        fetchFromGitHub {
          owner = "tomasklaen";
          repo = "uosc";
          rev = "1ed8a7a823ce05df11cd46f09a295fae05dca0d2";
          sha256 = "TdOWG6hrPoU6nnWqsd0Uxjd/7hSJlIg0o3OIOhXfRsY=";
        }
        + "/scripts/uosc_shared";
    };

    "mpv/fonts" = {
      recursive = true;
      source =
        fetchFromGitHub {
          owner = "tomasklaen";
          repo = "uosc";
          rev = "1ed8a7a823ce05df11cd46f09a295fae05dca0d2";
          sha256 = "TdOWG6hrPoU6nnWqsd0Uxjd/7hSJlIg0o3OIOhXfRsY=";
        }
        + "/fonts";
    };
  };
  # }}}
  home.packages = with pkgs;
    [yt-dlp ffmpeg obs-studio]
    ++ (
      if workMode
      then []
      else [
        spotify
        deadbeef
        handbrake
        mkvtoolnix
      ]
    );
}
