-- all following highlight groups will be cleared
local hiclear = {
  -- hide trailing whitespace marker
  "ExtraWhitespace",
  "IlluminatedWordRead",
  "IlluminatedWordWrite",
  "IlluminatedWordText",

  "DiffAdd",
  "DiffChange",
  "DiffDelete",
  "DiffText",

  "FlashMatch",
  "FlashLabel",
}

-- custom colors for plugin effects

local signifyAdd = "#2DD671"
local signifyDel = "#d94a0d"
local signifyChange = "#e6bf12"

local diffChangedForeground = "#F6ED56"
local diffChangedColor = "#41423F"
local diffAddedColor = "#38463F"
local diffRemovedColor = "#41343A"

local flashMatch = "#81a1c1"
local flashLabel = "#A3BE8C"

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
  GitSignsStagedAdd = "guifg=" .. diffAddedColor,
  GitSignsStagedAddLn = "guifg=" .. diffAddedColor,
  GitSignsStagedAddNr = "guifg=" .. diffAddedColor,
  GitSignsStagedDelete = "guifg=" .. diffRemovedColor,
  GitSignsStagedDeleteLn = "guifg=" .. diffRemovedColor,
  GitSignsStagedDeleteNr = "guifg=" .. diffRemovedColor,
  GitSignsStagedChange = "guifg=" .. diffChangedColor,
  GitSignsStagedChangeLn = "guifg=" .. diffChangedColor,
  GitSignsStagedChangeNr = "guifg=" .. diffChangedColor,

  -- illuminate word -- it tends confusing when visual selecting
  IlluminatedWordRead = "gui=underline",
  IlluminatedWordWrite = "gui=underline",
  IlluminatedWordText = "gui=underline",

  -- softer colors for diffing and diffview
  DiffAdd = "guibg=" .. diffAddedColor,
  DiffChange = "guibg=" .. diffChangedColor,
  DiffDelete = "guibg=" .. diffRemovedColor .. " gui=strikethrough",
  DiffText = "guibg=" .. diffChangedColor .. " guifg=" .. diffChangedForeground .. " gui=bold",

  -- flash.nvim jumping highlight
  FlashMatch = "guifg=" .. flashMatch .. " gui=underline",
  FlashLabel = "guifg=" .. flashLabel,

  -- remove italics
  ["@property"] = "gui=NONE",
  ["@string"] = "gui=NONE",
}

local hilink = {
  LspInlayHint = "Comment"
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
