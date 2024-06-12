-- Plugins Setups
-- The more significant chunks of configs are in the plugins subdir, leaving
-- only the minor components here.

---@diagnostic disable: missing-fields

-- notification framework
require("plugins.noice")
-- telescope fuzzy selection
require("plugins.telescope")
-- syntax parser
require("plugins.treesitter")
-- rainbow delimiter and indentation
require("plugins.rainbow")
-- zen-mode
require("plugins.zen")
-- custom highlighting
require("plugins.highlights")
-- bottom status line
require("plugins.lualine")
-- sign-column
require("plugins.signs")
-- nvim tree
require("plugins.nvimtree")
-- errors, hints, etc
require("plugins.diagnostics")
-- bookmarks
require("plugins.arrow")
-- devdocs
require("plugins.devdocs")
-- regex explainer
require("plugins.regexexplainer")
-- diffview
require("plugins.diffview")
-- tags
require("plugins.tags")

-- IME switching based on context
if vim.fn.has("macunix") then
	vim.g.macosime_cjk_ime = "com.sogou.inputmethod.sogou.pinyin"
end
