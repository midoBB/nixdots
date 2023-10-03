vim.cmd [[command! -nargs=1 Browse OpenBrowser <args>]]
local function augroup(name)
  return vim.api.nvim_create_augroup('mnv_' .. name, { clear = true })
end
local maugroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup 'highlight_yank',
  pattern = '*',
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  command = 'checktime',
})

-- Go to last loction when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- windows to close
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'OverseerForm',
    'OverseerList',
    'checkhealth',
    'floggraph',
    'fugitive',
    'help',
    'nofile',
    'lspinfo',
    'man',
    'neotest-output',
    'neotest-summary',
    'qf',
    'spectre_panel',
    'startuptime',
    'vim',
    'notify',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_set_hl(0, 'TerminalCursorShape', { underline = true })
vim.api.nvim_create_autocmd('TermEnter', {
  callback = function()
    vim.cmd [[setlocal winhighlight=TermCursor:TerminalCursorShape]]
  end,
})

vim.api.nvim_create_autocmd('VimLeave', {
  callback = function()
    vim.cmd [[set guicursor=a:ver25]]
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'wrap_spell',
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = augroup 'auto_format_options',
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
})

-- start git messages in insert mode
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'buf_check',
  pattern = { 'NeogitCommitMessage' },
  command = 'startinsert | 1',
})

autocmd('FileType', {
  desc = 'Unlist quickfist buffers',
  group = maugroup('unlist_quickfist', { clear = true }),
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_augroup('bufcheck', {
  clear = true,
})

-- remove extra spaces when saving
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = ':%s/\\s\\+$//e',
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o',
})

-- remove extra spaces when saving
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = ':%s/\\s\\+$//e',
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o',
})

-- Don't auto commenting new lines

vim.api.nvim_create_augroup('General', {
  clear = true,
})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'General',
  pattern = { '*.{,z,ba}sh', '*.pl', '*.py' },
  desc = 'Make files executable',
  callback = function()
    vim.fn.system { 'chmod', '+x', vim.fn.expand '%' }
  end,
})
