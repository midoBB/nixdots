return {
  {
    dir = "~/Workspace/nvim-quicktype",
    ft = {
      "java",
      "go",
      "typescriptreact",
      "typescript",
      "swift",
      "elm",
      "ruby",
      "python",
      "dart",
      "haskell",
    },
    --stylua: ignore
    keys = {
      { '<localleader>gj', function() require('nvim-quicktype').generate_type() end, desc = 'Type from json' },
      { '<leader>lgj', function() require('nvim-quicktype').generate_type() end, desc = 'Type from json' },
    },
  },
  {
    "danymat/neogen",
    opts = {
      snippet_engine = "luasnip",
      enabled = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
        rust = {
          template = {
            annotation_convention = "rustdoc",
          },
        },
        javascript = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
        typescript = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
        typescriptreact = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
      },
    },
    --stylua: ignore
    keys = {
      { '<localleader>gd', function() require('neogen').generate() end, desc = 'Annotation' },
      { '<localleader>gc', function() require('neogen').generate { type = 'class' } end, desc = 'Class' },
      { '<localleader>gf', function() require('neogen').generate { type = 'func' } end, desc = 'Function' },
      { '<localleader>gt', function() require('neogen').generate { type = 'type' } end, desc = 'Type' },
      { '<leader>lgd', function() require('neogen').generate() end, desc = 'Annotation' },
      { '<leader>lgc', function() require('neogen').generate { type = 'class' } end, desc = 'Class' },
      { '<leader>lgf', function() require('neogen').generate { type = 'func' } end, desc = 'Function' },
      { '<leader>lgt', function() require('neogen').generate { type = 'type' } end, desc = 'Type' },
    },
  },
}
