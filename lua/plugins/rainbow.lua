local safe_require = require('lib.meta').safe_require
local mix_colors = require('lib.colors').mix_colors

local function highlight(name, vis)
  vim.cmd("highlight " .. name .. " " .. vis)
end

local M = {}

-- rainbow delimiters
M.rainbow_colors = {
  "#F6ED56",
  "#A6C955",
  "#4BA690",
  "#4191C9",
  "#2258A0",
  "#654997",
  "#994D95",
  "#D45196",
  "#DB3A35",
  "#E5783A",
  "#EC943F",
  "#F7C247",
}

M.rainbow_groups = {}
local rainbow_delim_prefix = "RainbowDelim"
for i, color in ipairs(M.rainbow_colors) do
  highlight(rainbow_delim_prefix..i, "guifg="..color)
  table.insert(M.rainbow_groups, rainbow_delim_prefix..i)
end
-- slightly darker variant
M.rainbow_dark_groups = {}
local bg = "#2E3440"
local blend_factor = 0.3
local rainbow_dark_delim_prefix = "RainbowDarkDelim"
for i, color in ipairs(M.rainbow_colors) do
  local darker = mix_colors(color, bg, blend_factor)
  highlight(rainbow_dark_delim_prefix..i, "guifg="..darker)
  table.insert(M.rainbow_dark_groups, rainbow_dark_delim_prefix..i)
end

vim.g.rainbow_delimiters = {
  highlight = M.rainbow_groups
}

-- ibl
local hooks = safe_require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  for i, color in ipairs(M.rainbow_colors) do
    vim.api.nvim_set_hl(0, rainbow_delim_prefix..i, { fg = color })
  end
end)

safe_require('ibl').setup({
  indent = { char = "", highlight = M.rainbow_dark_groups },
  scope = { char = "", highlight = M.rainbow_groups },
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)


return M
