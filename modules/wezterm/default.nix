{
  programs.wezterm = {
    colorSchemes = {
      tokyonight = {
        ansi = [
          "#15161e"
          "#f7768e"
          "#9ece6a"
          "#e0af68"
          "#7aa2f7"
          "#bb9af7"
          "#7dcfff"
          "#a9b1d6"
        ];
        background = "#1a1b26";
        brights = [
          "#414868"
          "#f7768e"
          "#9ece6a"
          "#e0af68"
          "#7aa2f7"
          "#bb9af7"
          "#7dcfff"
          "#c0caf5"
        ];
        cursor_bg = "#c0caf5";
        cursor_border = "#c0caf5";
        cursor_fg = "#15161e";
        foreground = "#c0caf5";
        selection_bg = "#33467c";
        selection_fg = "#c0caf5";
      };
    };
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")
      return {
        warn_about_missing_glyphs = false,
        harfbuzz_features = {
          "calt=1", -- https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-calt
          "clig=1", -- https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-clig
          "liga=1", -- Ligatures
          "zero=0", -- 0 with slash or dot
          "ss01=0", -- * Asterisk normal or raised
          "ss02=0", -- Script variant of font
          "ss06=0", -- @ variants
          "ss07=1", -- {} variations
          "ss08=1", -- () variations
          "ss09=1", -- >= 2 sharacters wide or not
          "ss10=0", -- >= Alternate appearance for 1 char width
          "ss11=1", -- 0xF Alternate hex appearance
          "ss12=0", -- \\ Thin backslash (ruins ASCII art)
        },
        font_size = 13.0,
        font = wezterm.font "Iosevka Term",
        -- To ignore updates because nix manages them
        check_for_updates = false,
        show_update_window = false,
        window_close_confirmation = 'NeverPrompt',
        color_scheme = "tokyonight",
        enable_tab_bar = false,
        window_padding = {
            left = 8,
            right = 8,
            top = 4,
            bottom = 4,
        },
        keys = {
                {   key="e",
                    mods="CTRL|ALT",
                    action=wezterm.action{QuickSelectArgs={ patterns={
                        "http?://\\S+",
                        "https?://\\S+"
                    },
                    action = wezterm.action_callback(function(window, pane)
                            local url = window:get_selection_text_for_pane(pane)
                            wezterm.open_with(url)
                            end)
                    } }
                },
                {
                    key = 'f',
                    mods = 'CTRL|SHIFT',
                    action = wezterm.action.DisableDefaultAssignment,
                },
                {
                    key = 'p',
                    mods = 'CTRL|SHIFT',
                    action = wezterm.action.DisableDefaultAssignment,
                },
                {
                    key = 't',
                    mods = 'CTRL|SHIFT',
                    action = wezterm.action.DisableDefaultAssignment,
                },
                {
                    key = 'l',
                    mods = 'CTRL|SHIFT',
                    action = wezterm.action.DisableDefaultAssignment,
                },
        },
      }
    '';
  };
}
