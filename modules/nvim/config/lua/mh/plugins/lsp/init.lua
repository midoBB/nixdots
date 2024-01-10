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
    },
    config = function()
      require("mh.plugins.lsp.servers").setup()
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "mfussenegger/nvim-dap",
        config = function(self, opts)
          -- Debug settings if you're using nvim-dap
          local dap = require("dap")

          dap.configurations.scala = {
            {
              type = "scala",
              request = "launch",
              name = "RunOrTest",
              metals = {
                runType = "runOrTestFile",
                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
              },
            },
            {
              type = "scala",
              request = "launch",
              name = "Test Target",
              metals = {
                runType = "testTarget",
              },
            },
          }
        end,
      },
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      local map = vim.keymap.set
      local fn = vim.fn
      -- Example of settings
      metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      }

      -- *READ THIS*
      -- I *highly* recommend setting statusBarProvider to true, however if you do,
      -- you *have* to have a setting to display this in your statusline or else
      -- you'll not see any messages from metals. There is more info in the help
      -- docs about this
      -- metals_config.init_options.statusBarProvider = "on"

      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      metals_config.on_attach = function(client, bufnr)
        require("metals").setup_dap()

        -- LSP mappings
        map("n", "gD", vim.lsp.buf.definition)
        map("n", "K", vim.lsp.buf.hover)
        map("n", "gi", vim.lsp.buf.implementation)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "gds", vim.lsp.buf.document_symbol)
        map("n", "gws", vim.lsp.buf.workspace_symbol)
        map("n", "<leader>cl", vim.lsp.codelens.run)
        map("n", "<leader>sh", vim.lsp.buf.signature_help)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map("n", "<leader>f", vim.lsp.buf.format)
        map("n", "<leader>ca", vim.lsp.buf.code_action)

        map("n", "<leader>ws", function()
          require("metals").hover_worksheet()
        end)

        -- all workspace diagnostics
        map("n", "<leader>aa", vim.diagnostic.setqflist)

        -- all workspace errors
        map("n", "<leader>ae", function()
          vim.diagnostic.setqflist({ severity = "E" })
        end)

        -- all workspace warnings
        map("n", "<leader>aw", function()
          vim.diagnostic.setqflist({ severity = "W" })
        end)

        -- buffer diagnostics only
        map("n", "<leader>d", vim.diagnostic.setloclist)

        map("n", "[c", function()
          vim.diagnostic.goto_prev({ wrap = false })
        end)

        map("n", "]c", function()
          vim.diagnostic.goto_next({ wrap = false })
        end)

        -- Example mappings for usage with nvim-dap. If you don't use that, you can
        -- skip these
        map("n", "<leader>dc", function()
          require("dap").continue()
        end)

        map("n", "<leader>dr", function()
          require("dap").repl.toggle()
        end)

        map("n", "<leader>dK", function()
          require("dap.ui.widgets").hover()
        end)

        map("n", "<leader>dt", function()
          require("dap").toggle_breakpoint()
        end)

        map("n", "<leader>dso", function()
          require("dap").step_over()
        end)

        map("n", "<leader>dsi", function()
          require("dap").step_into()
        end)

        map("n", "<leader>dl", function()
          require("dap").run_last()
        end)
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
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
          nls.builtins.formatting.black,
          --[[ nls.builtins.diagnostics.ruff, ]]

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
          nls.builtins.formatting.prettierd.with({
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
          nls.builtins.diagnostics.eslint.with({
            args = {
              "-f",
              "json",
              "--stdin",
              "--stdin-filename",
              "$FILENAME",
            },
          }),
          nls.builtins.code_actions.eslint,
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
