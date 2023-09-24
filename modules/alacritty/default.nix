{
  pkgs,
  colorscheme,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {"TERM" = "xterm-256color";};

      window = {
        title = "floatt";
        class = {
          instance = "floatt";
          general = "floatt";
        };
        decorations = "none";
        padding = {
          x = 6;
          y = 6;
        };
        dynamic_padding = false;
      };

      # Cursor style
      #
      # Values for 'style':
      #   - ▇ Block
      #   - _ Underline
      #   - | Beam
      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };

      # Shell
      #
      # You can set `shell.program` to the path of your favorite shell, e.g. `/bin/fish`.
      # Entries in `shell.args` are passed unmodified as arguments to the shell.
      # shell = { program = "/home/mh/.nix-profile/bin/nu"; };
      shell = {program = "zsh";};

      url = {
        launcher = {
          program = "${pkgs.xdg-utils}/bin/xdg-open";
          args = [];
          modifiers = "";
        };
      };
      # Colors (One Dark)
      colors = {
        # Default colors
        primary = {
          background = colorscheme.bg-primary;
          foreground = colorscheme.fg-primary;

          # Bright and dim foreground colors
          #
          # The dimmed foreground color is calculated automatically if it is not
          # present.  If the bright foreground color is not set, or
          # `draw_bold_text_with_bright_colors` is `false`, the normal foreground
          # color will be used.
          #dim_foreground  = "0x9a9a9a";
          bright_foreground = colorscheme.fg-primary-bright;
        };

        # Cursor colors
        #
        # Colors which should be used to draw the terminal cursor. If these are unset,
        # the cursor color will be the inverse of the cell color.
        #cursor
        #  text  = "0x000000";
        #  cursor  = "0xffffff";

        # Normal colors
        normal = {
          inherit (colorscheme) black;
          inherit (colorscheme) red;
          inherit (colorscheme) green;
          inherit (colorscheme) yellow;
          inherit (colorscheme) blue;
          inherit (colorscheme) magenta;
          inherit (colorscheme) cyan;
          inherit (colorscheme) white;
        };
      };
    };
  };
}
