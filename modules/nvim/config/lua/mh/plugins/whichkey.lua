local conf = {
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
  },
}

local opts = {
  mode = 'n', -- Normal mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
  ['<space>'] = { '<cmd>Telescope buffers<cr>', 'Search Buffers' },
  a = {
    name = '+[A]pplictions',
    n = { name = '+[N]otes' },
  },
  q = {
    name = '+[Q]uit',
    t = { '<cmd>tabclose<cr>', 'Close Tab' },
    q = { '<cmd>qa<CR>', 'Quit' },
  },
  t = {
    name = '+[T]asks',
  },
  b = {
    name = '+[B]uffer',
    s = { '<cmd>update!<CR>', 'Save' },
    c = { '<cmd>BufDelOthers<CR>', 'Close the other buffers' },
    d = { '<cmd>BufDel<CR>', 'Close the current buffer' },
    f = { '<cmd>Telescope buffers<cr>', 'Find buffer' },
  },
  s = {
    name = '+[S]earch',
    f = { '<cmd>Telescope find_files<cr>', 'Search File' },
    g = { '<cmd>Telescope live_grep<cr>', 'Search Text' },
    s = { '<cmd>Telescope oldfiles<cr>', 'Search Recents' },
    C = { '<cmd>Telescope command_history<cr>', 'Search Previous commands' },
    c = { '<cmd>Telescope commands<cr>', 'Search Available commands' },
  },
  x = {
    name = '+Te[x]t',
    i = {
      name = 'Case',
      c = { "<cmd>lua require('textcase').current_word('to_camel_case')<cr>", '    To lowerCamelCase' },
      C = { "<cmd>lua require('textcase').current_word('to_pascal_case')<cr>", '   To UpperCamelCase' },
      k = { "<cmd>lua require('textcase').current_word('to_dash_case')<cr>", '     To kebab-case' },
      u = { "<cmd>lua require('textcase').current_word('to_snake_case')<cr>", '    To under_score' },
      U = { "<cmd>lua require('textcase').current_word('to_constant_case')<cr>", ' To UP_CASE' },
    },
  },
  u = {
    name = '+[U]I',
  },
  w = {
    name = '+[W]indow',
    ['='] = { '<C-w>=', 'Balance split windows' },
    d = { '<cmd>close<CR>', 'Delete a window' },
    w = { '<C-w>|', 'Max out the width' },
    x = { '<C-w>_', 'Max out the height' },
    s = { '<cmd>split<CR>', 'Split hortizentally' },
    v = { '<cmd>vsplit<CR>', 'Split Vertically' },
    e = { '<C-w><C-r>', 'Exchange current window with next one' },
    j = { "<cmd>lua require('smart-splits').move_cursor_down()<cr>", 'move to window below' },
    k = { "<cmd>lua require('smart-splits').move_cursor_up()<cr>", 'move to window above' },
    l = { "<cmd>lua require('smart-splits').move_cursor_left()<cr>", 'move to window on the right' },
    h = { "<cmd>lua require('smart-splits').move_cursor_right()<cr>", 'move to window on the left' },
  },
  l = {
    name = '+[L]SP',
    d = {
      name = '+[D]ebugging',
    },
  },
  g = {
    name = '+[G]it',
    t = { name = '+[T]oggle' },
    c = { name = '+[C]onflict' },
    h = { name = '+[H]unks' },
  },
}

return {
  {
    'folke/which-key.nvim',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 150
    end,
    config = function()
      local whichkey = require 'which-key'
      whichkey.setup(conf)
      whichkey.register(mappings, opts)
    end,
  },
}
