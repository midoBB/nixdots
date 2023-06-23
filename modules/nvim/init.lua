local data = {
  kind = {
    Class = "ﴯ",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Namespace = "",
    Number = "",
    Operator = "",
    Package = "",
    Property = "ﰠ",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
    -- ccls-specific icons.
    TypeAlias = "",
    Parameter = "",
    StaticMethod = "",
    Macro = "",
  },
  type = {
    Array = "",
    Boolean = "",
    Null = "ﳠ",
    Number = "",
    Object = "",
    String = "",
  },
  documents = {
    Default = "",
    File = "",
    Files = "",
    FileTree = "פּ",
    Import = "",
    Symlink = "",
  },
  git = {
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
  },
  ui = {
    ArrowClosed = "",
    ArrowOpen = "",
    BigCircle = "",
    BigUnfilledCircle = "",
    BookMark = "",
    Bug = "",
    Calendar = "",
    Check = "",
    ChevronRight = "",
    Circle = "",
    Close = "",
    Close_alt = "",
    CloudDownload = "",
    Comment = "",
    CodeAction = "",
    Dashboard = "",
    Emoji = "",
    EmptyFolder = "",
    EmptyFolderOpen = "",
    File = "",
    Fire = "",
    Folder = "",
    FolderOpen = "",
    Gear = "",
    History = "",
    Incoming = "",
    Indicator = "",
    Keyboard = "",
    Left = "",
    List = "",
    Square = "",
    SymlinkFolder = "",
    Lock = "",
    Modified = "✥",
    Modified_alt = "",
    NewFile = "",
    Newspaper = "",
    Note = "",
    Outgoing = "",
    Package = "",
    Pencil = "",
    Perf = "",
    Play = "",
    Project = "",
    Right = "",
    RootFolderOpened = "",
    Search = "",
    Separator = "",
    DoubleSeparator = "",
    SignIn = "",
    SignOut = "",
    Sort = "",
    Spell = "暈",
    Symlink = "",
    Table = "",
    Telescope = "",
  },
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Question = "",
    Hint = "",
    -- Holo version
    Error_alt = "",
    Warning_alt = "",
    Information_alt = "",
    Question_alt = "",
    Hint_alt = "",
  },
  misc = {
    Campass = "",
    Code = "",
    EscapeST = "✺",
    Gavel = "",
    Glass = "",
    PyEnv = "",
    Squirrel = "",
    Tag = "",
    Tree = "",
    Watch = "",
    Lego = "",
    Vbar = "│",
    Add = "+",
    Added = "",
    Ghost = "",
    ManUp = "",
    Vim = "",
  },
  cmp = {
    Copilot = "",
    Copilot_alt = "",
    nvim_lsp = "",
    nvim_lua = "",
    path = "",
    buffer = "",
    spell = "暈",
    luasnip = "",
    treesitter = "",
  },
  dap = {
    Breakpoint = "",
    BreakpointCondition = "ﳁ",
    BreakpointRejected = "",
    LogPoint = "",
    Pause = "",
    Play = "",
    RunLast = "↻",
    StepBack = "",
    StepInto = "",
    StepOut = "",
    StepOver = "",
    Stopped = "",
    Terminate = "ﱢ",
  },
}
--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

--- Resolve the options table for a given plugin with lazy
---@param plugin string The plugin to search for
---@return table opts # The plugin options
function plugin_opts(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  local lazy_plugin_avail, lazy_plugin = pcall(require, "lazy.core.plugin")
  local opts = {}
  if lazy_config_avail and lazy_plugin_avail then
    local spec = lazy_config.plugins[plugin]
    if spec then
      opts = lazy_plugin.values(spec, "opts")
    end
  end
  return opts
end
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

local function map(mode, lhs, rhs, opts)
  local options = {
    noremap = true,
    silent = true,
  }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
vim.g.mapleader = " "

local options = {
  -- meta settings
  backup = false,
  belloff = "all",
  bufhidden = "wipe",
  cdhome = true,
  mouse = "",
  clipboard = "",
  completeopt = "menuone,noinsert,noselect", -- Autocomplete options
  backspace = "indent,eol,start",
  timeoutlen = 300,
  confirm = true,
  errorbells = false,
  fileencoding = "utf-8",
  icon = true,
  mousehide = true,
  swapfile = false,
  undofile = true,
  updatetime = 50,
  verbose = 0,
  visualbell = false,
  spell = false,
  -- indentation
  autoindent = true,
  breakindent = true,
  copyindent = true,
  expandtab = true,
  preserveindent = true,
  smartindent = true,
  smarttab = true,
  shiftwidth = 4,
  tabstop = 4,
  shiftround = true,
  hidden = true,
  -- visuals
  background = "dark",
  cmdheight = 1,
  cursorcolumn = false,
  cursorline = true,
  helpheight = 8,
  menuitems = 8,
  laststatus = 3,
  number = true,
  pumheight = 8,
  pumblend = 17,
  relativenumber = true,
  scrolloff = 8,
  showmode = false,
  showmatch = true,
  showcmd = true,
  colorcolumn = "80",
  sidescroll = 1,
  sidescrolloff = 8,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  syntax = "ON",
  termguicolors = true,
  linebreak = false,
  wrap = true,
  wrapmargin = 8,
  list = true,
  fillchars = {
    vert = "█",
    horiz = "▀",
    horizup = "█",
    horizdown = "█",
    vertleft = "█",
    vertright = "█",
    verthoriz = "█",
  },
  -- code folding
  foldcolumn = "1",
  foldlevel = 99,
  foldlevelstart = 99,
  foldenable = true,
  -- search settingsop
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  wrapscan = true,
  wildignore = "__pychache__",
  whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line
  sessionoptions = "blank,buffers,curdir,winsize,winpos,localoptions",
  inccommand = "split",
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

vim.opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*", "*.lock" })
-- -- Disable builtin plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
vim.g.undotree_SetFocusWhenToggle = 1
-- }}}
require("lazy").setup({
  "tpope/vim-repeat",
  "tpope/vim-sleuth",
  "airblade/vim-rooter",
  "mbbill/undotree",
  "NoahTheDuke/vim-just",
  {
    "stevearc/overseer.nvim",
    opts = {},
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", branch = "legacy", opts = {} },
      "folke/neodev.nvim",
      "SmiteshP/nvim-navic",
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      mode = "workspace_diagnostics",
      fold_open = data.ui.ArrowOpen,
      fold_closed = data.ui.ArrowClosed,
      auto_jump = { "lsp_definitions" },
      auto_fold = true,
      use_diagnostic_signs = true,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
    },
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        on_open = function()
          vim.cmd("IndentBlanklineDisable")
        end,
        on_close = function()
          vim.cmd("IndentBlanklineEnable")
        end,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  { "mrjones2014/smart-splits.nvim" },
  {
    "tummetott/reticle.nvim",
    event = "VeryLazy", -- lazyload the plugin if you like
    opts = {},
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = { store_selection_keys = "<C-x>" },
    config = function(_, opts)
      if opts then
        require("luasnip").config.setup(opts)
      end
      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      local lspkind_status_ok, lspkind = pcall(require, "lspkind")
      if not snip_status_ok then
        return
      end
      local border_opts = {
        border = "single",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
        enabled = function()
          local dap_prompt = is_available("cmp-dap") -- add interoperability with cmp-dap
            and vim.tbl_contains(
              { "dap-repl", "dapui_watches", "dapui_hover" },
              vim.api.nvim_get_option_value("filetype", { buf = 0 })
            )
          if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" and not dap_prompt then
            return false
          end
          return vim.g.cmp_enabled
        end,
        preselect = cmp.PreselectMode.None,
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind_status_ok and lspkind.cmp_format(plugin_opts("lspkind.nvim")) or nil,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          cmp_tabnine = 1,
          buffer = 1,
          path = 1,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
      }
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    config = function()
      require("highlight-undo").setup({
        hlgroup = "HighlightUndo",
        duration = 300,
        keymaps = {
          { "n", "u", "undo", {} },
          { "n", "U", "redo", {} },
        },
      })
    end,
  },
  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = false,
        },

        hover = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      messages = {
        enabled = true, -- enables the Noice messages UI
        view = "mini", -- default view for messages
        view_error = "mini", -- view for errors
        view_warn = "mini", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "*",
          },
          opts = {
            skip = true,
          },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = {
            skip = true,
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = data.git.Add },
        change = { text = data.git.Mod_alt },
        delete = { text = data.git.Remove },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        vim.keymap.set(
          "n",
          "<leader>gp",
          require("gitsigns").prev_hunk,
          { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>gn",
          require("gitsigns").next_hunk,
          { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>ph",
          require("gitsigns").preview_hunk,
          { buffer = bufnr, desc = "[P]review [H]unk" }
        )
      end,
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = { floating = { border = "rounded" } },
        config = function(_, opts)
          local dap, dapui = require("dap"), require("dapui")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
          dapui.setup(opts)
        end,
      },
      {
        "rcarriga/cmp-dap",
        dependencies = { "nvim-cmp" },
        config = function()
          require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
            sources = {
              { name = "dap" },
            },
          })
        end,
      },
      -- Add your own debuggers here
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<F6>", dap.pause)
      vim.keymap.set("n", "<F17>", dap.terminate)
      vim.keymap.set("n", "<F29>", dap.restart_frame)
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
      vim.keymap.set("n", "<F21>", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end)

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup({
        icons = { expanded = data.ui.ArrowOpen, collapsed = data.ui.ArrowClosed, current_frame = "*" },
        controls = {
          icons = {
            pause = data.dap.Pause,
            play = data.dap.Play,
            step_into = data.dap.StepInfo,
            step_over = data.dap.StepOver,
            step_out = data.dap.StepOut,
            step_back = data.dap.StepBack,
            run_last = data.dap.RunLast,
            terminate = data.dap.Teminate,
            disconnect = "⏏",
          },
        },
      })
      -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
      vim.keymap.set("n", "<F7>", dapui.toggle)

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- Install golang specific config
      require("dap-go").setup()
    end,
  },
  {
    -- Theme inspired by Atom
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  { "tiagovla/scope.nvim", opts = {} },
  {
    "roobert/bufferline-cycle-windowless.nvim",
    dependencies = {
      { "akinsho/bufferline.nvim" },
    },
    config = function()
      require("bufferline-cycle-windowless").setup({
        -- whether to start in enabled or disabled mode
        default_enabled = true,
      })
    end,
  },
  { "nvim-lualine/lualine.nvim" },
  { "ojroques/nvim-bufdel" },
  { "famiu/bufdelete.nvim" },
  { "b0o/incline.nvim" },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    "numToStr/Comment.nvim",
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
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-context",
    },
  },
  {
    "TimUntersberger/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      disable_commit_confirmation = true,
      disable_signs = true,
      auto_refresh = false,
      disable_builtin_notifications = true,
      integrations = {
        diffview = true,
      },
    },
  },
  { "sindrets/diffview.nvim" },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "stevearc/resession.nvim",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  "ggandor/leap.nvim",
  "ggandor/flit.nvim",
  "Vonr/align.nvim",
  { "johmsalas/text-case.nvim", opts = {} },
}, {})

require("leap").add_default_mappings()
require("flit").setup({
  multiline = false,
  labeled_modes = "nvo",
})
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  hijack_cursor = true,
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
})
require("bufferline").setup({
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        text_align = "left",
        padding = 1,
      },
    },
    mode = "buffers", -- tabs or buffers
    numbers = "none",
    diagnostics = "nvim_lsp",
    separator_style = "slant" or "padded_slant",
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
})
require("bufferline-cycle-windowless").setup({
  default_enabled = true,
})

local function get_diagnostic_label(props)
  local icons = {
    Error = data.diagnostics.Error,
    Warn = data.diagnostics.Warning,
    Info = data.diagnostics.Information,
    Hint = data.diagnostics.Hint,
  }

  local label = {}
  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, {
      severity = vim.diagnostic.severity[string.upper(severity)],
    })
    if n > 0 then
      local fg = "#"
        .. string.format("%06x", vim.api.nvim_get_hl_by_name("DiagnosticSign" .. severity, true)["foreground"])
      table.insert(label, {
        icon .. " " .. n .. " ",
        guifg = fg,
      })
    end
  end
  return label
end

local function get_git_diff(props)
  local icons = {
    removed = data.git.Remove,
    changed = data.git.Mod_alt,
    added = data.git.Add,
  }
  local labels = {}
  local signs = vim.api.nvim_buf_get_var(props.buf, "gitsigns_status_dict")
  -- local signs = vim.b.gitsigns_status_dict
  for name, icon in pairs(icons) do
    if tonumber(signs[name]) and signs[name] > 0 then
      table.insert(labels, {
        icon .. " " .. signs[name] .. " ",
        group = "Diff" .. name,
      })
    end
  end
  if #labels > 0 then
    table.insert(labels, { "| " })
  end
  return labels
end

require("incline").setup({
  debounce_threshold = {
    falling = 500,
    rising = 250,
  },
  hide = {
    only_win = true,
  },
  render = function(props)
    local bufname = vim.api.nvim_buf_get_name(props.buf)
    local filename = vim.fn.fnamemodify(bufname, ":t")
    local diagnostics = get_diagnostic_label(props)
    local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"
    local filetype_icon, color = require("nvim-web-devicons").get_icon_color(filename)

    local buffer = {
      { get_git_diff(props) },
      {
        filetype_icon,
        guifg = color,
      },
      { " " },
      {
        filename,
        gui = modified,
      },
    }

    if #diagnostics > 0 then
      table.insert(diagnostics, {
        "| ",
        guifg = "grey",
      })
    end
    for _, buffer_ in ipairs(buffer) do
      table.insert(diagnostics, buffer_)
    end
    return diagnostics
  end,
})
local hl_list = {}
for i, color in pairs({ "#E06C75", "#E5C07B", "#98C379", "#56B6C2", "#61AFEF", "#C678DD" }) do
  local name = "IndentBlanklineIndent" .. i
  vim.api.nvim_set_hl(0, name, {
    fg = color,
  })
  table.insert(hl_list, name)
end
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup({
  show_end_of_line = true,
  space_char_blankline = " ",
  char_highlight_list = hl_list,
  space_char_highlight_list = hl_list,
  show_current_context = true,
  show_current_context_start = true,
})

local metals_stats = function()
  local status = vim.g["metals_status"]
  if status == nil then
    return ""
  else
    return status
  end
end

local function get_palette()
  return {
    rosewater = "#DC8A78",
    flamingo = "#DD7878",
    mauve = "#CBA6F7",
    pink = "#F5C2E7",
    red = "#E95678",
    maroon = "#B33076",
    peach = "#FF8700",
    yellow = "#F7BB3B",
    green = "#AFD700",
    sapphire = "#36D0E0",
    blue = "#61AFEF",
    sky = "#04A5E5",
    teal = "#B5E8E0",
    lavender = "#7287FD",
    text = "#F2F2BF",
    subtext1 = "#BAC2DE",
    subtext0 = "#A6ADC8",
    overlay2 = "#C3BAC6",
    overlay1 = "#988BA2",
    overlay0 = "#6E6B6B",
    surface2 = "#6E6C7E",
    surface1 = "#575268",
    surface0 = "#302D41",
    base = "#1D1536",
    mantle = "#1C1C19",
    crust = "#161320",
  }
end
local icons = {}

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"ui"|"diagnostics"|"misc"|"cmp"|"dap"
---@param add_space? boolean @Add trailing space after the icon.
function icons.get(category, add_space)
  if add_space then
    return setmetatable({}, {
      __index = function(_, key)
        return data[category][key] .. " "
      end,
    })
  else
    return data[category]
  end
end

local colors = get_palette()
local icons = {
  diagnostics = icons.get("diagnostics", true),
  misc = icons.get("misc", true),
  ui = icons.get("ui", true),
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local navic = require("nvim-navic")
local function get_cwd()
  local cwd = vim.fn.getcwd()
  local home = os.getenv("HOME")
  if cwd:find(home, 1, true) == 1 then
    cwd = "~" .. cwd:sub(#home + 1)
  end
  return icons.ui.RootFolderOpened .. cwd
end

local mini_sections = {
  lualine_a = { --[[ "filetype" ]]
  },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}
local outline = {
  sections = mini_sections,
  filetypes = {},
}
local diffview = {
  sections = mini_sections,
  filetypes = { "DiffviewFiles" },
}

local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end
local buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    disabled_filetypes = {},
    component_separators = "|",
    section_separators = {
      left = "",
      right = "",
    },
  },
  sections = {
    lualine_a = { { "mode" } },
    lualine_b = {
      { "b:gitsigns_head", icon = "" },
      {
        "diff",
        -- Is it me or the symbol for modified us really weird
        symbols = { added = data.git.Add, modified = data.git.Mod_alt, removed = data.git.Remove },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        source = diff_source,
      },
    },
    lualine_c = {
      {
        "filename",
        cond = buffer_not_empty,
        color = { fg = colors.magenta, gui = "bold" },
      },
    },
    lualine_x = {
      { metals_stats },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warning,
          info = icons.diagnostics.Information,
        },
      },
      { get_cwd },
    },
    lualine_y = { {
      "filetype",
      colored = true,
      icon_only = true,
    } },
    lualine_z = { --[[ "progress", "location" ]]
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "nvim-tree", "nvim-dap-ui", "toggleterm", "fugitive", outline, diffview },
})

-- Workaround to make the global statusline look shifted over when nvim tree is
-- active
local nvim_tree_shift = {
  function()
    return string.rep(" ", vim.api.nvim_win_get_width(require("nvim-tree.view").get_winnr()) - 1)
  end,
  cond = require("nvim-tree.view").is_visible,
  color = "BufferInactive",
}

require("lualine").setup({
  sections = {
    lualine_a = { nvim_tree_shift, "mode" },
  },
})
-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Configure Treesitter ]]
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = { "comment" },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  indent = { enable = true },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<M-space>",
    },
  },
})
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<esc>"] = actions.close,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
})
require("telescope").load_extension("fzy_native")
map("n", "gx", "<cmd>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>", { desc = "Open Link" })

-- Resession config
local function get_session_name()
  local name = vim.fn.getcwd()
  local branch = vim.fn.system("git branch --show-current")
  if vim.v.shell_error == 0 then
    return name .. branch
  else
    return name
  end
end

local resession = require("resession")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only load the session if nvim was started with no args
    if vim.fn.argc(-1) == 0 then
      resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
    end
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    resession.save(get_session_name(), { dir = "dirsession", notify = false })
  end,
})
