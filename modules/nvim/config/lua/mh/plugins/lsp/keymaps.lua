local M = {}

local wk = require 'which-key'
function M.on_attach(client, buffer)
  local self = M.new(client, buffer)

  -- stylua: ignore
  self:map("gd", 'Lspsaga goto_definition', { desc = "Goto Definition" })
  self:map('gr', 'Lspsaga finder', { desc = 'References' })
  self:map('gD', 'Lspsaga peek_definition', { desc = 'Peek Definition' })
  -- stylua: ignore
  self:map("gI", 'Lspsaga finder imp', { desc = "Goto Implementation" })
  -- stylua: ignore
  self:map("gy", 'Lspsaga goto_type_definition', { desc = "Goto Type Definition" })
  self:map('K', 'Lspsaga hover_doc', { desc = 'Hover' })
  self:map('gK', vim.lsp.buf.signature_help, { desc = 'Signature Help', has = 'signatureHelp' })
  self:map('gl', function()
    vim.diagnostic.open_float()
  end, { desc = 'See Line diagnostics' })
  self:map(')d', M.diagnostic_goto(true), { desc = 'Next Diagnostic' })
  self:map('(d', M.diagnostic_goto(false), { desc = 'Prev Diagnostic' })
  self:map(')e', M.diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
  self:map('(e', M.diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
  self:map(')w', M.diagnostic_goto(true, 'WARNING'), { desc = 'Next Warning' })
  self:map('(w', M.diagnostic_goto(false, 'WARNING'), { desc = 'Prev Warning' })
  self:map('<leader>la', 'CodeActionMenu', { desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' })
  self:map('<localleader>a', 'CodeActionMenu', { desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' })
  self:map('<leader>ll', vim.lsp.codelens.run, { desc = 'Lens Action' })
  self:map('<localleader>l', vim.lsp.codelens.run, { desc = 'Lens Action' })

  local format = require('mh.plugins.lsp.format').format
  self:map('<leader>lf', format, { desc = 'Format Document', has = 'documentFormatting' })
  self:map('<leader>lf', format, { desc = 'Format Range', mode = 'v', has = 'documentRangeFormatting' })
  self:map('<leader>lr', M.rename, { expr = true, desc = 'Rename', has = 'rename' })
  self:map('<localleader>f', format, { desc = 'Format Document', has = 'documentFormatting' })
  self:map('<localleader>f', format, { desc = 'Format Range', mode = 'v', has = 'documentRangeFormatting' })
  self:map('<localleader>r', M.rename, { expr = true, desc = 'Rename', has = 'rename' })

  self:map('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = 'Workspace Symbols' })
  self:map('<leader>ls', 'Lspsaga outline', { desc = 'Document Symbols' })
  self:map('<localleader>s', 'Lspsaga outline', { desc = 'Document Symbols' })
  self:map('<leader>ltw', require('mh.plugins.lsp.utils').toggle_diagnostics, { desc = 'Toggle Inline Diagnostics' })
  self:map('<localleader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = 'Workspace Symbols' })
  self:map('<localleader>tw', require('mh.plugins.lsp.utils').toggle_diagnostics, { desc = 'Toggle Inline Diagnostics' })
  if vim.lsp.inlay_hint then
    self:map('<localleader>ti', function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = 'Toggle Inlay hints' })
    self:map('<leader>lti', function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = 'Toggle Inlay hints' })
  end
  local mappings = {
    t = { name = '+[T]oggle' },
  }
  wk.register(mappings, { prefix = '<leader>l' })
  wk.register(mappings, { prefix = '<localleader>' })
end

function M.new(client, buffer)
  return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
  return self.client.server_capabilities[cap .. 'Provider']
end

function M:map(lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not self:has(opts.has) then
    return
  end
  vim.keymap.set(
    opts.mode or 'n',
    lhs,
    type(rhs) == 'string' and ('<cmd>%s<cr>'):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
  )
end

function M.rename()
  if pcall(require, 'inc_rename') then
    return ':IncRename ' .. vim.fn.expand '<cword>'
  else
    vim.lsp.buf.rename()
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

return M
