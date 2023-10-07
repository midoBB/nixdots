return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
    },
    opts = {
      lsp_inlay_hints = {
        enable = false,
      },
    },
    ft = { "go", "gomod" },
    event = "LspAttach",
    keys = {
      {
        "<leader>lct",
        "<cmd>GoModTidy<cr>",
        desc = "Go mod tidy",
      },
      {
        "<localleader>ct",
        "<cmd>GoModTidy<cr>",
        desc = "Go mod tidy",
      },
      {
        "<leader>lca",
        "<cmd>GoAddTag<cr>",
        desc = "Go Add tags",
      },
      {
        "<localleader>ca",
        "<cmd>GoAddTag<cr>",
        desc = "Go Add tags",
      },
      {
        "<leader>lcr",
        "<cmd>GoRmTag<cr>",
        desc = "Go Remove tags",
      },
      {
        "<localleader>cr",
        "<cmd>GoRmTag<cr>",
        desc = "Go Remove tags",
      },
      {
        "<leader>lcf",
        "<cmd>GoFillStruct<cr>",
        desc = "Autofill struct",
      },
      {
        "<localleader>cf",
        "<cmd>GoFillStruct<cr>",
        desc = "Autofill struct",
      },
      {
        "<leader>lct",
        "<cmd>GoAddAllTest<cr>",
        desc = "Generate tests",
      },
      {
        "<localleader>ct",
        "<cmd>GoAddAllTest<cr>",
        desc = "Generate tests",
      },
      {
        "<leader>lce",
        "<cmd>GoIfErr<cr>",
        desc = "Generate If Err",
      },
      {
        "<localleader>ce",
        "<cmd>GoIfErr<cr>",
        desc = "Generate If Err",
      },
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    opts = {},
  },
}
