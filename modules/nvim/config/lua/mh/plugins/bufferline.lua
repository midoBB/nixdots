return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        offsets = {
          { filetype = "NvimTree", text = "", text_align = "left", padding = 1 },
          { filetype = "OverseerList", text = "", text_align = "left", padding = 1 },
        },
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "padded_slant",
        show_tab_indicators = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        enforce_regular_tabs = false,
        custom_filter = function(buf_number, _)
          local tab_num = 0
          for _ in pairs(vim.api.nvim_list_tabpages()) do
            tab_num = tab_num + 1
          end

          if tab_num > 1 then
            if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
              return true
            end
          else
            return true
          end
        end,
        sort_by = function(buffer_a, buffer_b)
          local mod_a = ((vim.loop.fs_stat(buffer_a.path) or {}).mtime or {}).sec or 0
          local mod_b = ((vim.loop.fs_stat(buffer_b.path) or {}).mtime or {}).sec or 0
          return mod_a > mod_b
        end,
      },
    },
  },
  {
    "roobert/bufferline-cycle-windowless.nvim",
    enabled = false,
    dependencies = { "akinsho/bufferline.nvim" },
    keys = {
      { "<S-h>", "<cmd>BufferLineCycleWindowlessPrev<CR>" },
      { "<leader>bp", "<cmd>BufferLineCycleWindowlessPrev<CR>", desc = "Previous buffer" },
      { "<S-l>", "<cmd>BufferLineCycleWindowlessNext<CR>" },
      { "<leader>bn", "<cmd>BufferLineCycleWindowlessNext<CR>", desc = "Next buffer" },
    },
    config = function()
      require("bufferline-cycle-windowless").setup({
        default_enabled = true,
      })
    end,
  },
  {
    "ojroques/nvim-bufdel",
  },
}
