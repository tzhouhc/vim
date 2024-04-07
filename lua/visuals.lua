-- theme
vim.cmd("colorscheme nord")

-- other options
vim.opt.conceallevel=2
vim.opt.concealcursor="nc"
vim.opt.foldlevelstart=99
vim.opt.colorcolumn="80"

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

-- quickscope
highlight("QuickScopePrimary", "guifg=#71eb34 gui=underline")
highlight("QuickScopeSecondary", "guifg=#348feb gui=bold")

if vim.api.nvim_win_get_option(0, "diff") then
  vim.opt.diffopt="filler,context:1000000"
end

-- rainbow delimiters
highlight("RainbowDelim0", "guifg=#F6ED56")
highlight("RainbowDelim1", "guifg=#A6C955")
highlight("RainbowDelim2", "guifg=#4BA690")
highlight("RainbowDelim3", "guifg=#4191C9")
highlight("RainbowDelim4", "guifg=#2258A0")
highlight("RainbowDelim5", "guifg=#654997")
highlight("RainbowDelim6", "guifg=#994D95")
highlight("RainbowDelim7", "guifg=#D45196")
highlight("RainbowDelim8", "guifg=#DB3A35")
highlight("RainbowDelim9", "guifg=#E5783A")
highlight("RainbowDelim10", "guifg=#EC943F")
highlight("RainbowDelim11", "guifg=#F7C247")

require('rainbow-delimiters.setup').setup {
  highlight = {
    'RainbowDelim0',
    'RainbowDelim1',
    'RainbowDelim2',
    'RainbowDelim3',
    'RainbowDelim4',
    'RainbowDelim5',
    'RainbowDelim6',
    'RainbowDelim7',
    'RainbowDelim8',
    'RainbowDelim9',
    'RainbowDelim10',
    'RainbowDelim11',
  }
}

-- diffview
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
require('diffview').setup {
  enhanced_diff_hl = true,
}
