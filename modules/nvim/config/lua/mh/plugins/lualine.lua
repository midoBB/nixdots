local navic = require 'nvim-navic'
local function get_palette()
  return {
    rosewater = '#DC8A78',
    flamingo = '#DD7878',
    mauve = '#CBA6F7',
    pink = '#F5C2E7',
    red = '#E95678',
    maroon = '#B33076',
    peach = '#FF8700',
    yellow = '#F7BB3B',
    green = '#AFD700',
    sapphire = '#36D0E0',
    blue = '#61AFEF',
    sky = '#04A5E5',
    teal = '#B5E8E0',
    lavender = '#7287FD',
    text = '#F2F2BF',
    subtext1 = '#BAC2DE',
    subtext0 = '#A6ADC8',
    overlay2 = '#C3BAC6',
    overlay1 = '#988BA2',
    overlay0 = '#6E6B6B',
    surface2 = '#6E6C7E',
    surface1 = '#575268',
    surface0 = '#302D41',
    base = '#1D1536',
    mantle = '#1C1C19',
    crust = '#161320',
  }
end
local data = {
  kind = {
    Class = 'ﴯ',
    Color = '',
    Constant = '',
    Constructor = '',
    Enum = '',
    EnumMember = '',
    Event = '',
    Field = '',
    File = '',
    Folder = '',
    Function = '',
    Interface = '',
    Keyword = '',
    Method = '',
    Module = '',
    Namespace = '',
    Number = '',
    Operator = '',
    Package = '',
    Property = 'ﰠ',
    Reference = '',
    Snippet = '',
    Struct = '',
    Text = '',
    TypeParameter = '',
    Unit = '',
    Value = '',
    Variable = '',
    -- ccls-specific icons.
    TypeAlias = '',
    Parameter = '',
    StaticMethod = '',
    Macro = '',
  },
  type = {
    Array = '',
    Boolean = '',
    Null = 'ﳠ',
    Number = '',
    Object = '',
    String = '',
  },
  documents = {
    Default = '',
    File = '',
    Files = '',
    FileTree = 'פּ',
    Import = '',
    Symlink = '',
  },
  git = {
    Add = ' ',
    Branch = '',
    Diff = '',
    Git = '',
    Ignore = '',
    Mod = 'M',
    Mod_alt = ' ',
    Remove = ' ',
    Rename = '',
    Repo = '',
    Unmerged = 'שׂ',
    Untracked = 'ﲉ',
    Unstaged = '',
    Staged = '',
    Conflict = '',
  },
  ui = {
    ArrowClosed = '',
    ArrowOpen = '',
    BigCircle = '',
    BigUnfilledCircle = '',
    BookMark = '',
    Bug = '',
    Calendar = '',
    Check = '',
    ChevronRight = '',
    Circle = '',
    Close = '',
    Close_alt = '',
    CloudDownload = '',
    Comment = '',
    CodeAction = '',
    Dashboard = '',
    Emoji = '',
    EmptyFolder = '',
    EmptyFolderOpen = '',
    File = '',
    Fire = '',
    Folder = '',
    FolderOpen = '',
    Gear = '',
    History = '',
    Incoming = '',
    Indicator = '',
    Keyboard = '',
    Left = '',
    List = '',
    Square = '',
    SymlinkFolder = '',
    Lock = '',
    Modified = '✥',
    Modified_alt = '',
    NewFile = '',
    Newspaper = '',
    Note = '',
    Outgoing = '',
    Package = '',
    Pencil = '',
    Perf = '',
    Play = '',
    Project = '',
    Right = '',
    RootFolderOpened = '',
    Search = '',
    Separator = '',
    DoubleSeparator = '',
    SignIn = '',
    SignOut = '',
    Sort = '',
    Spell = '暈',
    Symlink = '',
    Table = '',
    Telescope = '',
  },
  diagnostics = {
    Error = '',
    Warning = '',
    Information = '',
    Question = '',
    Hint = '',
    -- Holo version
    Error_alt = '',
    Warning_alt = '',
    Information_alt = '',
    Question_alt = '',
    Hint_alt = '',
  },
  misc = {
    Campass = '',
    Code = '',
    EscapeST = '✺',
    Gavel = '',
    Glass = '',
    PyEnv = '',
    Squirrel = '',
    Tag = '',
    Tree = '',
    Watch = '',
    Lego = '',
    Vbar = '│',
    Add = '+',
    Added = '',
    Ghost = '',
    ManUp = '',
    Vim = '',
  },
  cmp = {
    Copilot = '',
    Copilot_alt = '',
    nvim_lsp = '',
    nvim_lua = '',
    path = '',
    buffer = '',
    spell = '暈',
    luasnip = '',
    treesitter = '',
  },
  dap = {
    Breakpoint = '',
    BreakpointCondition = 'ﳁ',
    BreakpointRejected = '',
    LogPoint = '',
    Pause = '',
    Play = '',
    RunLast = '↻',
    StepBack = '',
    StepInto = '',
    StepOut = '',
    StepOver = '',
    Stopped = '',
    Terminate = 'ﱢ',
  },
}
local icons = {}

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"ui"|"diagnostics"|"misc"|"cmp"|"dap"
---@param add_space? boolean @Add trailing space after the icon.
function icons.get(category, add_space)
  if add_space then
    return setmetatable({}, {
      __index = function(_, key)
        return data[category][key] .. ' '
      end,
    })
  else
    return data[category]
  end
end

local colors = get_palette()
local icons = {
  diagnostics = icons.get('diagnostics', true),
  misc = icons.get('misc', true),
  ui = icons.get('ui', true),
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

--[[ local navic = require 'nvim-navic' ]]
local function get_cwd()
  local cwd = vim.fn.getcwd()
  local home = os.getenv 'HOME'
  if cwd:find(home, 1, true) == 1 then
    cwd = '~' .. cwd:sub(#home + 1)
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
  filetypes = { 'DiffviewFiles' },
}

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg '/'
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return icons.ui.Search .. last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end
local buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand '%:t') ~= 1
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        disabled_filetypes = {},
        component_separators = '|',
        section_separators = {
          left = '',
          right = '',
        },
      },
      sections = {
        lualine_a = { { 'mode' } },
        lualine_b = {
          { 'b:gitsigns_head', icon = '' },
          {
            'diff',
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
            'filename',
            cond = buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' },
          },
          {
            function()
              return navic.get_location()
            end,
            cond = function()
              return navic.is_available()
            end,
          },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warning,
              info = icons.diagnostics.Information,
            },
          },
          { get_cwd },
          { search_result },
          { 'overseer' },
        },
        lualine_y = { {
          'filetype',
          colored = true,
          icon_only = true,
        } },
        lualine_z = { --[[ "progress", "location" ]]
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'quickfix', 'nvim-tree', 'nvim-dap-ui', 'fugitive', outline, diffview },
    }
    vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
    vim.api.nvim_create_autocmd('User LspProgressStatusUpdated', {
      group = 'lualine_augroup',
      callback = require('lualine').refresh,
    })
    --[[ -- Workaround to make the global statusline look shifted over when nvim tree is
    -- active
    local nvim_tree_shift = {
      function()
        return string.rep(' ', vim.api.nvim_win_get_width(require('nvim-tree.view').get_winnr()) - 1)
      end,
      cond = require('nvim-tree.view').is_visible,
      color = 'BufferInactive',
    }

    require('lualine').setup {
      sections = {
        lualine_a = { nvim_tree_shift, 'mode' },
      },
    } ]]
  end,
}
