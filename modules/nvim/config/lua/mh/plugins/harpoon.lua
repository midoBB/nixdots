return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<C-e>",
        '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
      },
      {
        "<leader>ba",
        '<cmd>lua require("harpoon.mark").add_file()<cr>',
        desc = "Add File to Harpoon",
      },
    },
  },
}
