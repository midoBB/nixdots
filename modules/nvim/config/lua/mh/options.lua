local options = {
  -- meta settings
  backup = false,
  belloff = 'all',
  bufhidden = 'wipe',
  cdhome = true,
  mouse = '',
  clipboard = '',
  completeopt = 'menuone,noinsert,noselect', -- Autocomplete options
  backspace = 'indent,eol,start',
  timeoutlen = 300,
  confirm = true,
  autoread = true,
  errorbells = false,
  title = true, -- change the terminal's title
  fileencoding = 'utf-8',
  icon = true,
  --[[ mousehide = true, ]]
  swapfile = false,
  undofile = true,
  updatetime = 50,
  verbose = 0,
  visualbell = false,
  spell = false,
  -- indentation
  autoindent = true,
  breakindent = true,
  copyindent = true,
  expandtab = true,
  preserveindent = true,
  smartindent = true,
  smarttab = true,
  shiftwidth = 2,
  tabstop = 2,
  shiftround = true,
  hidden = true,
  -- visuals
  background = 'dark',
  cursorcolumn = false,
  cursorline = true,
  helpheight = 8,
  menuitems = 8,
  laststatus = 3,
  number = true,
  pumheight = 8,
  pumblend = 17,
  relativenumber = true,
  scrolloff = 8,
  showmode = false,
  showmatch = true,
  showcmd = true,
  colorcolumn = '80',
  sidescroll = 1,
  sidescrolloff = 8,
  signcolumn = 'yes',
  splitbelow = true,
  list = true,
  splitright = true,
  syntax = 'ON',
  termguicolors = true,
  linebreak = false,
  wrap = true,
  wrapmargin = 8,
  fillchars = {
    vert = '█',
    horiz = '▀',
    horizup = '█',
    horizdown = '█',
    vertleft = '█',
    vertright = '█',
    verthoriz = '█',
    eob = ' ',
    fold = ' ',
    foldopen = '',
    foldsep = ' ',
    foldclose = '',
  },
  -- code folding
  foldcolumn = '1',
  foldlevel = 99,
  foldlevelstart = 99,
  cmdheight = 0,
  foldenable = true,
  -- search settingsop
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  wrapscan = true,
  whichwrap = 'bs<>[]hl', -- which "horizontal" keys are allowed to travel to prev/next line
  inccommand = 'split',
  listchars = {
    eol = '↲',
    tab = '  ',
    trail = '⋅',
    extends = '❯',
    precedes = '❮',
    nbsp = '⦸',
  },
}

for name, value in pairs(options) do
  vim.opt[name] = value
end
vim.opt.wildignore:append { '*.o', '*~', '*.pyc', '*pycache*', '*.lock' }
vim.cmd 'set nrformats-=octal'
-- -- Disable builtin plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  'tutor',
  'rplugin',
  'synmenu',
  'optwin',
  'compiler',
  'bugreport',
  'ftplugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})
vim.diagnostic.config {
  underline = true,
  update_in_insert = true,
  virtual_text = {
    source = 'always',
    prefix = '●',
  },
  severity_sort = true,
  float = {
    source = 'always',
    border = 'rounded',
    style = 'minimal',
  },
}
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end
