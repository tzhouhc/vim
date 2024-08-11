-- Visual Experience Configurations

-- other options
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.opt.foldlevelstart = 99
vim.opt.colorcolumn = "80"

-- all following highlight groups will be cleared
local hiclear = {}

-- apply the following higlight adjustments
local hilight = {
  -- italics
  Special = "gui=italic",
  Comment = "gui=italic",
  Italic = "gui=italic",
  Bold = "gui=bold",
  mkdBold = "gui=bold",
  htmlItalic = "gui=italic",
  ["@markup.strikethrough"] = "cterm=strikethrough term=strikethrough gui=strikethrough",
}

for _, hc in ipairs(hiclear) do
  vim.cmd("hi clear " .. hc)
end

for hg, gui in pairs(hilight) do
  vim.cmd("hi " .. hg .. " " .. gui)
end
