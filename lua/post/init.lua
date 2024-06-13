-- Plugins Setups
-- The more significant chunks of configs are in the plugins subdir, leaving
-- only the minor components here.

---@diagnostic disable: missing-fields

-- notification framework
require("post.noice")
-- telescope fuzzy selection
require("post.telescope")
-- rainbow delimiter and indentation
require("post.rainbow")
-- custom highlighting
require("post.highlights")
-- sign-column
require("post.signs")
-- errors, hints, etc
require("post.diagnostics")
-- regex explainer
require("post.regexexplainer")
-- tags
require("post.tags")

-- IME switching based on context
if vim.fn.has("macunix") then
	vim.g.macosime_cjk_ime = "com.sogou.inputmethod.sogou.pinyin"
end
