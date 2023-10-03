local ArrowClosed = ""
local ArrowOpen = ""
return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      mode = "workspace_diagnostics",
      fold_open = ArrowOpen,
      fold_closed = ArrowClosed,
      auto_jump = { "lsp_definitions" },
      auto_fold = true,
      use_diagnostic_signs = true,
    },
    lazy = true,
    keys = {
      { "<leader>li", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace issues" },
      { "<leader>ld", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
      { "<localleader>d", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
      { "<localleader>i", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace issues" },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
    },
    keys = { { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todos" } },
  },
}
