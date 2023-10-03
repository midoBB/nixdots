return {
  {
    'max397574/better-escape.nvim',
    config = true,
    event = 'InsertEnter',
  },
  {
    'abecodes/tabout.nvim',
    event = 'InsertEnter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp',
    },
    config = true,
  },
  {
    'phaazon/hop.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local hop = require 'hop'
      hop.setup {}
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
      end, { remap = true })
      vim.keymap.set('n', 's', function()
        hop.hint_char2()
      end, { remap = true })
      vim.keymap.set('x', 's', function()
        hop.hint_char2()
      end, { remap = true })
      vim.keymap.set('o', 's', function()
        hop.hint_char2()
      end, { remap = true })
    end,
  },
}
