return {

  { "gbprod/stay-in-place.nvim", event = "BufWinEnter", opts = {} },
  {
    "gbprod/yanky.nvim",
    event = "BufWinEnter",
    config = function()
      require("yanky").setup({
        preserve_cursor_position = {
          enabled = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 500,
        },
        system_clipboard = {
          sync_with_ring = false,
        },
      })
    end,
  },
  {
    "gbprod/cutlass.nvim",
    event = "BufWinEnter",
    opts = {
      cut_key = "m",
      exclude = { "ns", "nS" },
    },
  },
}
