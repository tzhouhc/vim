-- Visual Experience Configurations

-- other options
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.opt.foldlevelstart = 99
vim.opt.colorcolumn = "80"

-- diffview highlight groups
vim.opt.fillchars:append("diff:╱")

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

-- custom colors

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
	-- italics
	Special = "gui=italic",
	Comment = "gui=italic",
	Italic = "gui=italic",
	Bold = "gui=bold",
	mkdBold = "gui=bold",
	htmlItalic = "gui=italic",

	-- signify
	SignifySignAdd = "guifg=" .. signifyAdd,
	SignifySignDelete = "guifg=" .. signifyDel,
	SignifySignChange = "guifg=" .. signifyChange,

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
}

for _, hc in ipairs(hiclear) do
	vim.cmd("hi clear " .. hc)
end

for hg, gui in pairs(hilight) do
	vim.cmd("hi " .. hg .. " " .. gui)
end
