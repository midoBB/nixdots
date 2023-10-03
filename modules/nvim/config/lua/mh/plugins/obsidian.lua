return {
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Drive/Notes/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Drive/Notes/**.md",
    },
    keys = {
      { "<leader>ans", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find note" },
      { "<leader>ang", "<cmd>ObsidianSearch<cr>", desc = "Find note content" },
      { "<leader>sn", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find note" },
      { "<leader>ann", "<cmd>ObsidianNew<cr>", desc = "Create note" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      mappings = {},
      dir = "~/Drive/Notes",
    },
  },
  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = true,
    cmd = "Glow",
    keys = {
      { "<localleader>p", "<cmd>Glow<cr>", desc = "Preview" },
      { "<leader>lp", "<cmd>Glow<cr>", desc = "Preview" },
    },
  },
}
