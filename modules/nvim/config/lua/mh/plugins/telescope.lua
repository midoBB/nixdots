return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-telescope/telescope-fzy-native.nvim' },
    cmd = 'Telescope',
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      telescope.setup {
        defaults = {
          --[[ layout_strategy = "center", ]]
          prompt_prefix = ' ',
          selection_caret = ' ',
          path_display = { 'smart' },
          file_ignore_patterns = { '.git/', 'node_modules' },

          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
          },
        },

        extensions = {
          fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      }
      telescope.load_extension 'fzy_native'
    end,
  },
}
