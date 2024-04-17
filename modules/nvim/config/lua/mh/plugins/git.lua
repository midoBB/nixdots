local git = {
  Add = " ",
  Branch = "",
  Diff = "",
  Git = "",
  Ignore = "",
  Mod = "M",
  Mod_alt = " ",
  Remove = " ",
  Rename = "",
  Repo = "",
  Unmerged = "שׂ",
  Untracked = "ﲉ",
  Unstaged = "",
  Staged = "",
  Conflict = "",
  Topdelete = "󱅁",
  ChangeDelete = "󰍷",
}
return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gb", "<cmd>GBrowse<cr>", desc = "Open in browser" },
      { "<leader>gb", "<cmd>GBrowse<cr>", desc = "Open in browser", mode = "v" },
    },
    dependencies = {
      "tpope/vim-rhubarb",
      "shumphrey/fugitive-gitlab.vim",
    },
  },
  {
    "tanvirtin/vgit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = { { "<leader>gf", "<cmd>VGit buffer_history_preview<cr>", desc = "File log" } },
  },
  {
    "emmanueltouzery/agitator.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>gtb", "<cmd>lua require('agitator').git_blame_toggle()<cr>", desc = "Toggle blame" },
      {
        "<leader>ghb",
        function()
          local commit_sha = require("agitator").git_blame_commit_for_line()
          vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
        end,
        desc = "Toggle blame",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    config = true,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {
      integrations = { diffview = true },
      disable_commit_confirmation = true,
      signs = {
        hunk = { "", "" },
        item = { "", "" },
        section = { "", "" },
      },
    },
    keys = {
      { "<leader>gs", "<cmd>Neogit kind=tab<cr>", desc = "Status" },
    },
  },

  { --[[ FIXME: This is such an ugly hack ]]
    "akinsho/git-conflict.nvim",
    event = { "BufReadPre", "BufWritePre" },
    config = function()
      require("git-conflict").setup({
        disable_diagnostics = true,
        default_mappings = false,
        default_commands = true,
      })

      local function fold(callback, list, accum)
        for k, v in pairs(list) do
          accum = callback(accum, v, k)
          assert(accum ~= nil, "The accumulator must be returned on each iteration")
        end
        return accum
      end

      local function validate_autocmd(name, cmd)
        local keys = { "event", "buffer", "pattern", "desc", "command", "group", "once", "nested" }
        local incorrect = fold(function(accum, _, key)
          if not vim.tbl_contains(keys, key) then
            table.insert(accum, key)
          end
          return accum
        end, cmd, {})
        if #incorrect == 0 then
          return
        end
        vim.schedule(function()
          vim.notify("Incorrect keys: " .. table.concat(incorrect, ", "), vim.log.levels.ERROR, {
            title = string.format("Autocmd: %s", name),
          })
        end)
      end
      local function augroup(name, commands)
        local id = vim.api.nvim_create_augroup(name, { clear = true })
        for _, autocmd in ipairs(commands) do
          validate_autocmd(name, autocmd)
          local is_callback = type(autocmd.command) == "function"
          vim.api.nvim_create_autocmd(autocmd.event, {
            group = id,
            pattern = autocmd.pattern,
            desc = autocmd.desc,
            callback = is_callback and autocmd.command or nil,
            command = not is_callback and autocmd.command or nil,
            once = autocmd.once,
            nested = autocmd.nested,
            buffer = autocmd.buffer,
          })
        end
      end
      augroup("GitConflicts", {
        {
          event = { "User" },
          pattern = { "GitConflictDetected" },
          command = function(args)
            vim.g.git_conflict_detected = true
            BufMap("n", "<leader>gcs", "<cmd>GitConflictListQf<CR>", { desc = "send conflicts to qf" }, args.buf)
            BufMap("n", "<leader>gco", "<cmd>GitConflictChooseOurs<CR>", { desc = "choose ours" }, args.buf)
            BufMap("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<CR>", { desc = "choose both" }, args.buf)
            BufMap("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<CR>", { desc = "choose their" }, args.buf)
            BufMap("n", "(c", "<cmd>GitConflictPrevConflict<CR>", { desc = "prev conflict" }, args.buf)
            BufMap("n", ")c", "<cmd>GitConflictNextConflict<CR>", { desc = "next conflict" }, args.buf)
            vim.notify("Conflicts detected.")
            vim.defer_fn(function()
              vim.diagnostic.disable(args.buf)
              vim.cmd("LspStop")
            end, 250)
          end,
        },
        {
          event = { "User" },
          pattern = { "GitConflictResolved" },
          command = function(args)
            vim.notify("All conflicts resolved!")
            vim.defer_fn(function()
              vim.diagnostic.enable(args.buf)
              vim.cmd("LspStart")
              vim.g.git_conflict_detected = false
            end, 250)
          end,
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = git.Add },
        change = { text = git.Mod_alt },
        delete = { text = git.Remove },
        topdelete = { text = git.Topdelete },
        changedelete = { text = git.ChangeDelete },
      },
      -- update_debounce = 100,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
        map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
        --[[ map('n', '<leader>ghb', function()
          gs.blame_line { full = true }
        end, { desc = 'Blame Line' }) ]]
        --[[ map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'Toggle Line Blame' }) ]]
        map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, { desc = "Diff This ~" })
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle Delete" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
      end,
    },
  },
}
