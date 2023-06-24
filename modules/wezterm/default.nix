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
       local dimmer = { brightness = 0.1 }
      local function getRandomWallpaperPath()
        local directory = os.getenv("HOME") .. "/.local/share/wallpapers/wallpapers/"
        local files = {}

        -- Iterate over files in the directory
        for file in io.popen('ls "' .. directory .. '"'):lines() do
          table.insert(files, file)
        end

        -- Check if any files were found
        if #files > 0 then
          -- Select a random file from the list
          local randomIndex = math.random(1, #files)
          return directory .. files[randomIndex]
        else
          return nil -- No files found
        end
      end
       return {
         warn_about_missing_glyphs = false,

       background = {
        -- This is the deepest/back-most layer. It will be rendered first
        {
          source = {
            File = getRandomWallpaperPath(),
          },
          hsb = dimmer,
       }},
       cell_width = 1.09,
       harfbuzz_features = {
       "cv06=1",
       "cv14=1",
       "cv32=1",
       "ss04=1",
       "ss07=1",
       "ss09=1",
       },
        font_size = 13.0,
        font = wezterm.font("Iosevka Term"),
        font_rules = {
          {
            intensity = 'Bold',
            italic = true,
            font = wezterm.font {
              family = 'VictorMono',
              weight = 'Bold',
              style = 'Italic',
            },
          },
          {
            italic = true,
            intensity = 'Half',
            font = wezterm.font {
              family = 'VictorMono',
              weight = 'DemiBold',
              style = 'Italic',
            },
          },
          {
            italic = true,
            intensity = 'Normal',
            font = wezterm.font {
              family = 'VictorMono',
              style = 'Italic',
            },
          },
        },
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
