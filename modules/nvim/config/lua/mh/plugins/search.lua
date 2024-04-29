return {
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPre", "BufNewFile" },
  },
  {

    {
      "axieax/urlview.nvim",
      cmd = "UrlView",
      keys = {
        { "<A-u>", "<Cmd>UrlView<CR>", desc = "Open URLs", mode = "n" },
      },
    },
  },
  "romainl/vim-cool",
  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
    config = function()
      require("hlslens").setup()
      vim.cmd([[
                aug VMlens
                    au!
                    au User visual_multi_start lua require('mh.utils.vmlens').start()
                    au User visual_multi_exit lua require('mh.utils.vmlens').exit()
                aug END
              ]])
    end,
  },
  {
    "roobert/search-replace.nvim",
    keys = {
      { "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", desc = "Search and Replace", mode = "v" },
    },
    config = function()
      require("search-replace").setup({
        -- optionally override defaults
        default_replace_single_buffer_options = "gcI",
        default_replace_multi_buffer_options = "egcI",
      })
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    opts = {
      filter = {
        fzf = { extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" } },
      },
    },
    config = function()
      function OpenQF()
        local qf_name = "quickfix"
        local qf_empty = function()
          return vim.tbl_isempty(vim.fn.getqflist())
        end
        if not qf_empty() then
          vim.cmd.copen()
          vim.cmd.wincmd("J")
        else
          print(string.format("%s is empty.", qf_name))
        end
      end

      function FindQF(type)
        local wininfo = vim.fn.getwininfo()
        local win_tbl = {}
        for _, win in pairs(wininfo) do
          local found = false
          if type == "l" and win["loclist"] == 1 then
            found = true
          end
          if type == "q" and win["quickfix"] == 1 and win["loclist"] == 0 then
            found = true
          end
          if found then
            table.insert(win_tbl, {
              winid = win["winid"],
              bufnr = win["bufnr"],
            })
          end
        end
        return win_tbl
      end

      function OpenLoclistAll()
        local wininfo = vim.fn.getwininfo()
        local qf_name = "loclist"
        local qf_empty = function(winnr)
          return vim.tbl_isempty(vim.fn.getloclist(winnr))
        end
        for _, win in pairs(wininfo) do
          if win["quickfix"] == 0 then
            if not qf_empty(win["winnr"]) then
              vim.api.nvim_set_current_win(win["winid"])
              vim.cmd.lopen()
            else
              print(string.format("%s is empty.", qf_name))
            end
          end
        end
      end

      function ToggleQF(type)
        local windows = FindQF(type)
        if #windows > 0 then
          for _, win in ipairs(windows) do
            vim.api.nvim_win_hide(win.winid)
          end
        else
          if type == "l" then
            OpenLoclistAll()
          else
            OpenQF()
          end
        end
      end

      Map("n", "<C-c>", "<cmd>lua ToggleQF('q')<CR>", { desc = "Toggle quickfix window" })
    end,
  },
}
