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
-- bookmarks
safe_require("plugins.arrow")
-- devdocs
safe_require("plugins.devdocs")
-- regex explainer
safe_require("plugins.regexexplainer")
-- diffview
safe_require("plugins.diffview")

-- gutentags
vim.g.gutentags_cache_dir = os.getenv("VIM_HOME") .. "/tags"
-- custom tag file list using fd; see rest of dotfiles
vim.g.gutentags_file_list_command = "gutentagger"
vim.g.gutentags_resolve_symlinks = 1
vim.g.gutentags_define_advanced_commands = 1

-- IME switching based on context
if vim.fn.has("macunix") then
	vim.g.macosime_cjk_ime = "com.sogou.inputmethod.sogou.pinyin"
end
