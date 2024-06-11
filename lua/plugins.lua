-- Plugins Setups
-- The more significant chunks of configs are in the plugins subdir, leaving
-- only the minor components here.

---@diagnostic disable: missing-fields
local safe_require = require("lib.meta").safe_require

-- notification framework
safe_require("plugins.noice")
-- telescope fuzzy selection
safe_require("plugins.telescope")
-- syntax parser
safe_require("plugins.treesitter")
-- rainbow delimiter and indentation
safe_require("plugins.rainbow")
-- zen-mode
safe_require("plugins.zen")
-- custom highlighting
safe_require("plugins.highlights")
-- bottom status line
safe_require("plugins.lualine")
-- sign-column
safe_require("plugins.signs")
-- nvim tree
safe_require("plugins.nvimtree")
-- errors, hints, etc
safe_require("plugins.diagnostics")
-- bookmarks
safe_require("plugins.arrow")
-- devdocs
safe_require("plugins.devdocs")
-- regex explainer
safe_require("plugins.regexexplainer")
-- diffview
safe_require("plugins.diffview")
-- tags
safe_require("plugins.tags")

-- IME switching based on context
if vim.fn.has("macunix") then
	vim.g.macosime_cjk_ime = "com.sogou.inputmethod.sogou.pinyin"
end
