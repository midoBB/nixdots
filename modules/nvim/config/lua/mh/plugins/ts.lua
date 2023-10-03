return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-context',
      'windwp/nvim-ts-autotag',
      'IndianBoy42/tree-sitter-just',
      'cohama/lexima.vim',
      'NoahTheDuke/vim-just',
      'isobit/vim-caddyfile',
      { 'LiadOz/nvim-dap-repl-highlights', opts = {} },
    },
    config = function()
      require('nvim-dap-repl-highlights').setup()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'c',
          'cpp',
          'go',
          'lua',
          'python',
          'tsx',
          'javascript',
          'typescript',
          'vimdoc',
          'vim',
          'astro',
          'bash',
          'clojure',
          'diff',
          'dockerfile',
          'gitcommit',
          'gitignore',
          'gomod',
          'gosum',
          'haskell',
          'java',
          'html',
          'json',
          'markdown',
          'markdown_inline',
          'nix',
          'prisma',
          'proto',
          'regex',
          'ruby',
          'scala',
          'sql',
          'svelte',
          'toml',
          'xml',
          'yaml',
          'dap_repl',
        },
        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = false,
        highlight = {
          additional_vim_regex_highlighting = { 'markdown' },
          enable = true,
          ignore_install = { 'comment' },
          disable = { 'comment' },
        },
        indent = { enable = true },
        autotag = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
      }
    end,
  },
  {
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
}
