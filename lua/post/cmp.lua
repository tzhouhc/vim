-- Completion configurations

local colors = require("lib.colors")

-- Create bg color for each completion kind, asd

local bg = colors.bg_by_hlgroup("Pmenu")
if not bg then
  return
end

-- completion colors
for _, name in pairs(vim.fn.getcompletion('BlinkCmpKind*', 'highlight')) do
  local fg = colors.fg_by_hlgroup(name)
  if fg then
    -- local new_bg = colors.mix_colors(fg, bg, 0.9)
    -- The mixed result seems a bit dim.
    vim.api.nvim_set_hl(0, name, { bg = fg, fg = bg })
  end
end

vim.api.nvim_set_hl(0, "BlinkCmpKindText",
  { bg = bg, fg = colors.fg_by_hlgroup("BlinkCmpLabel") })
vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet",
  { bg = bg, fg = colors.fg_by_hlgroup("BlinkCmpLabel") })
