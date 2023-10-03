require("lazy").setup({
  "tpope/vim-sleuth",
  "nvim-lua/plenary.nvim",
  "tpope/vim-repeat",
  "MunifTanjim/nui.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    config = function()
      require("nvim-web-devicons").setup({
        override = require("nvim-material-icon").get_icons(),
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { relative = "editor" },
      select = {
        backend = { "telescope", "fzf", "builtin" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      -- background_colour = "#A3CCBE",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
    end,
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", mode = { "n", "v" } },
      { "<C-x>", mode = { "n", "v" } },
      { "g<C-a>", mode = { "v" } },
      { "g<C-x>", mode = { "v" } },
    },
    -- stylua: ignore
    init = function()
      vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { desc = "Decrement", noremap = true })
    end,
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  { import = "mh.plugins" },
}, { lockfile = "~/.dotfiles/modules/nvim/config/lazy-lock.json" })
