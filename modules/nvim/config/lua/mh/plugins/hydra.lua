return {
  {
    "anuvyklack/hydra.nvim",
    event = { "VeryLazy" },
    opts = {},
    config = function(_, opts)
      local hydra = require("hydra")
      for s, _ in pairs(opts.specs) do
        hydra(opts.specs[s]())
      end
    end,
  },
}
