return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "smjonas/inc-rename.nvim", config = true, event = "LspAttach" },
      { "SmiteshP/nvim-navic", event = "LspAttach" },
      { "kosayoda/nvim-lightbulb", event = "LspAttach", opts = {
        autocmd = { enabled = true },
      } },

      { "b0o/SchemaStore.nvim", ft = { "json", "yaml" } },
      { "weilbith/nvim-code-action-menu", event = "LspAttach" },
    },
    config = function()
      require("mh.plugins.lsp.servers").setup()
    end,
  },
  {
    "dnlhc/glance.nvim",
    event = "LspAttach",
    config = true,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = {
      "lua",
      "python",
      "nix",
      "prisma",
      "sql",
      "proto",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "html",
      "css",
      "json",
      "jsonc",
      "yaml",
      "graphql",
      "handlebars",
      "svelte",
      "markdown",
      "dockerfile",
      "xml",
      "go",
      "bash",
      "zsh",
      "sh",
    },
    config = function()
      local nls = require("null-ls")
      nls.setup({
        sources = {
          -- Lua
          nls.builtins.formatting.stylua,
          -- Python
          nls.builtins.formatting.ruff,
          nls.builtins.diagnostics.ruff,

          nls.builtins.formatting.alejandra, -- for nix
          nls.builtins.code_actions.statix, -- for nix
          nls.builtins.diagnostics.statix, -- for nix
          nls.builtins.formatting.prismaFmt, -- for node prisma db orm
          -- sql
          nls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "sqlite" },
          }),
          nls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "sqlite" },
          }),
          nls.builtins.formatting.protolint, --proto files
          -- webdev
          nls.builtins.formatting.prettier_d_slim.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "scss",
              "less",
              "html",
              "css",
              "json",
              "jsonc",
              "yaml",
              "graphql",
              "handlebars",
              "svelte",
              "markdown",
            },
          }),
          nls.builtins.diagnostics.eslint_d.with({
            args = {
              "-f",
              "json",
              "--stdin",
              "--stdin-filename",
              "$FILENAME",
            },
          }),
          nls.builtins.code_actions.eslint_d,
          --markdown
          nls.builtins.diagnostics.proselint,
          nls.builtins.code_actions.proselint,
          nls.builtins.diagnostics.markdownlint_cli2,
          -- Docker files
          nls.builtins.diagnostics.hadolint,
          -- Go
          nls.builtins.diagnostics.golangci_lint,
          nls.builtins.formatting.gofumpt,
          -- Bash
          nls.builtins.code_actions.shellcheck,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.formatting.beautysh,
          -- Yaml
          nls.builtins.diagnostics.yamllint,
          nls.builtins.formatting.jq,
          -- XML
          nls.builtins.diagnostics.tidy,
          nls.builtins.formatting.xmllint,
          -- Clojure
          nls.builtins.diagnostics.clj_kondo,
          nls.builtins.formatting.zprint,
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      fmt = {
        task = function(task_name, message, percentage)
          if task_name == "code_action" then
            return false
          end
          return string.format(
            "%s%s [%s]",
            message,
            percentage and string.format(" (%s%%)", percentage) or "",
            task_name
          )
        end,
      },
    },
  },
  {
    "VidocqH/lsp-lens.nvim",
    event = "LspAttach",
    config = true,
  },
}
