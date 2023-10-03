function Map(modes, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(modes) == "table" then
    for _, mode in ipairs(modes) do
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
  else
    vim.api.nvim_set_keymap(modes, lhs, rhs, options)
  end
end

function BufMap(modes, lhs, rhs, opts, buffer)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(modes) == "table" then
    for _, mode in ipairs(modes) do
      vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, options)
    end
  else
    vim.api.nvim_buf_set_keymap(buffer, modes, lhs, rhs, options)
  end
end

-- Disable arrow keys
Map("", "<up>", "<nop>")
Map("", "<down>", "<nop>")
Map("", "<left>", "<nop>")
Map("", "<right>", "<nop>")
Map("i", "<C-n>", "<Nop>")

--- Disable Recording & Ex Mode
Map("", "q", "<nop>")
Map("", "Q", "<nop>")

Map("n", "U", "<C-r>")

Map("n", "x", '"_x')
Map("n", "yw", "yiw")
Map("n", "dw", '"_diw')
Map("n", "cw", '"_ciw')
Map("n", "cc", '"_cc')
Map("v", "c", '"_c')
Map({ "v", "x" }, "p", '"_dP')
Map("n", "p", "<Plug>(YankyPutAfter)")
Map("x", "p", "<Plug>(YankyPutAfter)")
Map("n", "P", "<Plug>(YankyPutBefore)")
Map("x", "P", "<Plug>(YankyPutBefore)")
Map("n", "gp", "<Plug>(YankyGPutAfter)", { desc = "Paste and move cursor after" })
Map("n", "gP", "<Plug>(YankyGPutBefore)", { desc = "Paste and move cursor after" })
Map("n", "y", "<Plug>(YankyYank)")
Map("x", "y", "<Plug>(YankyYank)")
Map("n", "<leader>p", '"+gp', { desc = "Paste from clipboard" })
Map("n", "<leader>y", '"+y', { desc = "Copy to clipboard" })
Map("v", "<leader>p", '"+gp', { desc = "Paste from clipboard" })
Map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })

-- Move around splits using Ctrl + {h,j,k,l}
-- resizing splits
Map("n", "<A-h>", "<cmd>lua require('smart-splits').resize_left()<cr>")
Map("n", "<A-j>", "<cmd>lua require('smart-splits').resize_down()<cr>")
Map("n", "<A-k>", "<cmd>lua require('smart-splits').resize_up()<cr>")
Map("n", "<A-l>", "<cmd>lua require('smart-splits').resize_right()<cr>")
-- moving between splits
Map("n", "<C-h>", "<cmd>lua require('smart-splits').move_cursor_left()<cr>")
Map("n", "<C-j>", "<cmd>lua require('smart-splits').move_cursor_down()<cr>")
Map("n", "<C-k>", "<cmd>lua require('smart-splits').move_cursor_up()<cr>")
Map("n", "<C-l>", "<cmd>lua require('smart-splits').move_cursor_right()<cr>")

Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")
Map("n", "<C-o>", "<c-o>zz")
Map("n", "<C-i>", "<c-i>zz")

Map("n", "j", "gj")
Map("n", "k", "gk")

Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")
Map("x", "J", ":m '>+1<CR>gv=gv")
Map("x", "K", ":m '<-2<CR>gv=gv")
Map("n", ">", ">>")
Map("n", "<", "<<")
Map("x", ">", ">gv")
Map("x", "<", "<gv")

Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")
Map("x", "J", ":m '>+1<CR>gv=gv")
Map("x", "K", ":m '<-2<CR>gv=gv")
Map("n", ">", ">>")
Map("n", "<", "<<")
Map("x", ">", ">gv")
Map("x", "<", "<gv")

Map("n", "<S-l>", "<cmd>bNext<cr>")
Map("n", "<S-h>", "<cmd>bprevious<cr>")

Map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

Map("n", "gx", "<cmd>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>", { desc = "Open Link" })
