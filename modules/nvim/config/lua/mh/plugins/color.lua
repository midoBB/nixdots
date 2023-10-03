return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          mini = true,
          fidget = true,
          harpoon = true,
          lsp_saga = true,
          neogit = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
            inlay_hints = {
              background = true,
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          treesitter_context = true,
          overseer = true,
          neotest = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
    enabled = false,
  },
  { "xiyaowong/transparent.nvim", lazy = false },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = false,
    config = function()
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
