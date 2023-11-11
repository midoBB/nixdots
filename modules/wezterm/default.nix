{
  xdg.configFile."wezterm/colors/tokyonight.yml".source = ./tokyonight.toml;
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")
      local dimmer = { brightness = 0.05 }
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
          },
        },
        color_scheme = "tokyonight",
        cell_width = 1.09,
        font_size = 12.0,
        font = wezterm.font({
            family='Monaspace Argon',
            harfbuzz_features={ 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' },
          }),
        font_rules = {
          {
            intensity = 'Normal',
            italic = true,
            font = wezterm.font({
              family='Monaspace Radon',
              weight="ExtraLight",
              stretch="Normal",
              style="Normal",
              harfbuzz_features={ "calt", "liga", 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' },
            })
          },
          {
            intensity = 'Bold',
            italic = false,
            font = wezterm.font({
              family='Monaspace Krypton',
              weight="Light",
              stretch="Normal",
              style="Normal",
              harfbuzz_features={ 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' },
            })
          },
        },
        check_for_updates = false,
        show_update_window = false,
        window_close_confirmation = "NeverPrompt",
        color_scheme = "Breeze (Gogh)",
        enable_tab_bar = false,
        window_padding = {
          left = 8,
          right = 8,
          top = 4,
          bottom = 4,
        },
        keys = {
          {
            key = "e",
            mods = "CTRL|ALT",
            action = wezterm.action({
              QuickSelectArgs = {
                patterns = {
                  "http?://\\S+",
                  "https?://\\S+",
                },
                action = wezterm.action_callback(function(window, pane)
                  local url = window:get_selection_text_for_pane(pane)
                  wezterm.open_with(url)
                end),
              },
            }),
          },
          {
            key = "f",
            mods = "CTRL|SHIFT",
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = "p",
            mods = "CTRL|SHIFT",
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = "t",
            mods = "CTRL|SHIFT",
            action = wezterm.action.DisableDefaultAssignment,
          },
          {
            key = "l",
            mods = "CTRL|SHIFT",
            action = wezterm.action.DisableDefaultAssignment,
          },
        },
      }
    '';
  };
}
