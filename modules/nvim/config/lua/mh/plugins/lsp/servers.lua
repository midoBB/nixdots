local M = {}

local lsp_utils = require("mh.plugins.lsp.utils")
local navic = require("nvim-navic")
function M.setup()
  lsp_utils.on_attach(function(client, bufnr)
    require("mh.plugins.lsp.format").on_attach(client, bufnr)
    require("mh.plugins.lsp.keymaps").on_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end)

  local capabilities = lsp_utils.capabilities()
  local lspconfig = require("lspconfig")
  lspconfig.gopls.setup({
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          rangeVariableTypes = true,
        },
      },
    },
    capabilities = capabilities,
  })
  lspconfig.ltex.setup({ capabilities = capabilities })
  lspconfig.nil_ls.setup({ capabilities = capabilities })
  lspconfig.svelte.setup({ capabilities = capabilities })

  lspconfig.tailwindcss.setup({
    capabilities = capabilities,
    settings = {
      files = { exclude = { "**/.git/**", "**/node_modules/**", "**/*.md" } },
    },
  })

  lspconfig.prismals.setup({ capabilities = capabilities })
  lspconfig.dockerls.setup({ capabilities = capabilities })
  lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
  lspconfig.cssls.setup({
    capabilities = capabilities,
    settings = { css = { lint = { unknownAtRules = "ignore" } } },
  })
  lspconfig.eslint.setup({ capabilities = capabilities })
  lspconfig.html.setup({ capabilities = capabilities })
  lspconfig.bashls.setup({ capabilities = capabilities })
  lspconfig.clojure_lsp.setup({
    root_dir = require("mh.plugins.lsp.cloj-utils").get_lsp_cwd,
    init_options = {
      signatureHelp = true,
      codeLens = true,
    },
  })
  lspconfig.pylsp.setup({
    settings = {
      pylsp = {
        plugins = {
          -- formatter options
          black = { enabled = true },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          -- type checker
          pylsp_mypy = { enabled = true },
          -- auto-completion options
          jedi_completion = { fuzzy = true },
          -- import sorting
          pyls_isort = { enabled = true },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
    capabilities = capabilities,
  })
  lspconfig.jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
    capabilities = capabilities,
  })
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    filetypes = { "lua" },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim", "string", "require" },
        },
        hint = {
          enable = true,
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
        completion = { enable = true, callSnippet = "Replace" },
      },
    },
  })
end

return M
