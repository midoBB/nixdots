return {
  {
    'mbbill/undotree',
    keys = {
      {
        '<leader>bu',
        '<cmd>UndotreeToggle<cr>',
        desc = 'Undo tree',
      },
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
}
