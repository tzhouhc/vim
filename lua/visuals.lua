-- Visual Experience Configurations

-- other options
vim.opt.conceallevel=2
vim.opt.concealcursor="nc"
vim.opt.foldlevelstart=99
vim.opt.colorcolumn="80"

-- fold column
-- relative line number, sign column, custom folding, spacer
vim.o.statuscolumn = '%=%r%s%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " "} '

local function highclear(name)
  vim.cmd("hi clear "..name)
end

local function highlight(name, vis)
  vim.cmd("highlight " .. name .. " " .. vis)
end

-- italics
highlight("Special", "gui=italic")
highlight("Comment", "gui=italic")
highlight("Italic", "gui=italic")
highlight("Bold", "gui=bold")
highlight("mkdBold", "gui=bold")
highlight("htmlItalic", "gui=italic")

-- signify
highlight("SignifySignAdd", "guifg=#2dd671")
highlight("SignifySignDelete", "guifg=#d94a0d")
highlight("SignifySignChange", "guifg=#e6bf12")

if vim.api.nvim_win_get_option(0, "diff") then
  vim.opt.diffopt="filler,context:1000000"
end

-- diffview highlight groups
vim.opt.fillchars:append("diff:/")
local diffChangedForeground = "#F6ED56"
local diffChangedColor = "#41423F"
local diffAddedColor = "#38463F"
local diffRemovedColor = "#41343A"
local hlToClear = {
  "DiffAdd",
  "DiffChange",
  "DiffDelete",
  "DiffText",
}
for _, c in pairs(hlToClear) do
  highclear(c)
end

highlight("DiffAdd", "guibg="..diffAddedColor)
highlight("DiffChange", "guibg="..diffChangedColor)
highlight("DiffDelete", "guibg="..diffRemovedColor.." gui=strikethrough")
highlight("DiffText", "guibg="..diffChangedColor.." guifg="..diffChangedForeground.." gui=bold")

return M
