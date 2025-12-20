-- all following highlight groups will be cleared
local hiclear = {
  "DiffAdd",
  "DiffChange",
  "DiffDelete",
  "DiffText",

  "FlashMatch",
  "FlashLabel",

  "IlluminatedWordRead",
  "IlluminatedWordWrite",
  "IlluminatedWordText",
}

if vim.g.prevent_lsp_cursor_highlight then
  vim.api.nvim_set_hl(0, "LspReferenceRead", {})
  vim.api.nvim_set_hl(0, "LspReferenceWrite", {})
  vim.api.nvim_set_hl(0, "LspReferenceText", {})
end

-- custom colors for plugin effects

local signifyAdd = "#2DD671"
local signifyDel = "#d94a0d"
local signifyChange = "#e6bf12"

local diffChangedForeground = "#F6ED56"

local stagedAddedColor = "#297F56"
local stagedRemovedColor = "#9D3E1C"
local stagedChangedColor = "#B69557"
local diffAddedColor = "#38463F"
local diffRemovedColor = "#41343A"
local diffChangedColor = "#41423F"

local flashMatch = "#81a1c1"
local flashLabel = "#A3BE8C"

local diffDeleteStr
if vim.g.crossout_diff_delete then
  diffDeleteStr = "guibg=" .. diffRemovedColor .. " gui=strikethrough"
else
  diffDeleteStr = "guibg=" .. diffRemovedColor
end

local hilight = {
  -- signify
  SignifySignAdd = "guifg=" .. signifyAdd,
  SignifySignDelete = "guifg=" .. signifyDel,
  SignifySignChange = "guifg=" .. signifyChange,

  -- gitsigns
  GitSignsAdd = "guifg=" .. signifyAdd,
  GitSignsAddLn = "guifg=" .. signifyAdd,
  GitSignsAddNr = "guifg=" .. signifyAdd,
  GitSignsDelete = "guifg=" .. signifyDel,
  GitSignsDeleteLn = "guifg=" .. signifyDel,
  GitSignsDeleteNr = "guifg=" .. signifyDel,
  GitSignsChange = "guifg=" .. signifyChange,
  GitSignsChangeLn = "guifg=" .. signifyChange,
  GitSignsChangeNr = "guifg=" .. signifyChange,
  GitSignsStagedAdd = "guifg=" .. stagedAddedColor,
  GitSignsStagedAddLn = "guifg=" .. stagedAddedColor,
  GitSignsStagedAddNr = "guifg=" .. stagedAddedColor,
  GitSignsStagedDelete = "guifg=" .. stagedRemovedColor,
  GitSignsStagedDeleteLn = "guifg=" .. stagedRemovedColor,
  GitSignsStagedDeleteNr = "guifg=" .. stagedRemovedColor,
  GitSignsStagedChange = "guifg=" .. stagedChangedColor,
  GitSignsStagedChangeLn = "guifg=" .. stagedChangedColor,
  GitSignsStagedChangeNr = "guifg=" .. stagedChangedColor,

  -- illuminate word -- it tends confusing when visual selecting
  IlluminatedWordRead = "gui=underline",
  IlluminatedWordWrite = "gui=underline",
  IlluminatedWordText = "gui=underline",

  -- softer colors for diffing and diffview
  DiffAdd = "guibg=" .. diffAddedColor,
  DiffChange = "guibg=" .. diffChangedColor,
  DiffDelete = diffDeleteStr,
  DiffText = "guibg=" .. diffChangedColor .. " guifg=" .. diffChangedForeground .. " gui=bold",

  -- flash.nvim jumping highlight
  FlashMatch = "guifg=" .. flashMatch .. " gui=underline",
  FlashLabel = "guifg=" .. flashLabel,

  -- remove italics
  ["@property"] = "gui=NONE",
  ["@string"] = "gui=NONE",
}

local hilink = {
  LspInlayHint = "Comment",
}

for _, hc in ipairs(hiclear) do
  vim.cmd("hi clear " .. hc)
end

for hg, gui in pairs(hilight) do
  vim.cmd("hi " .. hg .. " " .. gui)
end

for hg, tg in pairs(hilink) do
  vim.cmd("hi link " .. hg .. " " .. tg)
end
