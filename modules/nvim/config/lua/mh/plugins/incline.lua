local function get_diagnostic_label(props)
  local icons = { error = "", warn = "", info = "", hint = "" }
  local label = {}

  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    if n > 0 then
      table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
    end
  end
  if #label > 0 then
    table.insert(label, { "| " })
  end
  return label
end
local field_format = {
  name = {
    guifg = "#a0a0a0",
    guibg = "#282828",
  },
  num = {
    guifg = "#968c81",
  },
  modified = {
    guifg = "#d6991d",
  },
  blocks = {
    gui = "bold",
    guifg = "#070707",
  },
}

return {
  "b0o/incline.nvim",
  enabled = true,
  config = function()
    require("incline").setup({
      render = function(props)
        local buffullname = vim.api.nvim_buf_get_name(props.buf)
        local bufname_t = vim.fn.fnamemodify(buffullname, ":t")
        local bufname = (bufname_t and bufname_t ~= "") and bufname_t or "[No Name]"

        -- optional devicon
        local devicon = { " " }
        local success, nvim_web_devicons = pcall(require, "nvim-web-devicons")
        if success then
          local bufname_r = vim.fn.fnamemodify(buffullname, ":r")
          local bufname_e = vim.fn.fnamemodify(buffullname, ":e")
          local base = (bufname_r and bufname_r ~= "") and bufname_r or bufname
          local ext = (bufname_e and bufname_e ~= "") and bufname_e or vim.fn.fnamemodify(base, ":t")
          local ic, hl = nvim_web_devicons.get_icon(base, ext, { default = true })
          devicon = {
            ic,
            " ",
            group = hl,
          }
        end
        -- buffer name
        local display_bufname = vim.tbl_extend("force", { bufname, " " }, field_format.name)
        -- modified indicator
        local modified_icon = {}
        if vim.api.nvim_get_option_value("modified", { buf = props.buf }) then
          modified_icon = vim.tbl_extend("force", { "● " }, field_format.modified)
          display_bufname.guifg = field_format.modified.guifg
        end
        local diagnostics = get_diagnostic_label(props)
        return {
          diagnostics,
          devicon,
          display_bufname,
          modified_icon,
        }
      end,
      window = {
        padding = {
          left = 2,
          right = 2,
        },
        placement = {
          horizontal = "right",
          vertical = "top",
        },
      },
    })
  end,
}
