return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
      {
        '<leader>e',
        '<cmd>NvimTreeToggle<cr>',
        desc = 'Project Explorer',
      },
    },
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      hijack_cursor = true,
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
    },
  },
}
