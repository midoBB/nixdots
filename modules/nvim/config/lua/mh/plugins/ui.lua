return {
  { 'mrjones2014/smart-splits.nvim', version = '>=1.0.0', opts = {}, event = 'UIEnter' },
  {
    'tummetott/reticle.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    enabled = true,
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
  {
    'folke/zen-mode.nvim',
    dependencies = {
      'lukas-reineke/indent-blankline.nvim',
      {
        'folke/twilight.nvim',
        opts = {},
      },
    },
    keys = { {
      '<leader>wc',
      '<cmd>ZenMode<cr>',
      desc = 'Enable distraction-free mode',
    } },
    config = function()
      require('zen-mode').setup {
        on_open = function()
          vim.cmd 'IBLDisable'
        end,
        on_close = function()
          vim.cmd 'IBLEnable'
        end,
      }
    end,
  },
  {
    'nvim-zh/colorful-winsep.nvim',
    config = true,
    event = { 'WinNew' },
  },
  {
    'stevearc/stickybuf.nvim',
    opts = {},
  },
}
