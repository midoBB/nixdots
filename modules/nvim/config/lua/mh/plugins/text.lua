return {

  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false },
  },
  {
    "johmsalas/text-case.nvim",
    event = "BufWinEnter",
    config = function()
      Map(
        "n",
        "<leader>xic",
        "<cmd>lua require('textcase').current_word('to_camel_case')<cr>",
        { desc = "    To lowerCamelCase" }
      )
      Map(
        "n",
        "<leader>xiC",
        "<cmd>lua require('textcase').current_word('to_pascal_case')<cr>",
        { desc = "   To UpperCamelCase" }
      )
      Map(
        "n",
        "<leader>xik",
        "<cmd>lua require('textcase').current_word('to_dash_case')<cr>",
        { desc = "     To kebab-case" }
      )
      Map(
        "n",
        "<leader>xiu",
        "<cmd>lua require('textcase').current_word('to_snake_case')<cr>",
        { desc = "    To under_score" }
      )
      Map(
        "n",
        "<leader>xiU",
        "<cmd>lua require('textcase').current_word('to_constant_case')<cr>",
        { desc = " To UP_CASE" }
      )
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufWinEnter",
    opts = {
      mappings = {
        extra = true,
      },
      pre_hook = function(ctx)
        local U = require("Comment.utils")

        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
          location = location,
        })
      end,
    },
  },
}
