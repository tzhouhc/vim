-- Plugins Post-Setups
-- Here are the more complicated setups for plugins that cannot be done
-- directly via the `opts` in lazy loading.

-- visual theme
require("post.theme")
-- key mappings using plugins
require("post.mappings")
-- notification framework
require("post.noice")
-- telescope fuzzy selection
require("post.telescope")
-- rainbow delimiter and indentation
require("post.rainbow")
-- sign-column
require("post.signs")
-- lualine customization
require("post.lualine")
-- errors, hints, etc
require("post.diagnostics")
-- tags
require("post.tags")
-- language services
require("post.lsp")
-- completions via nvim-cmp
require("post.completions")
-- commander
require("post.commands")
-- ime
require("post.ime")
-- ai code completion
require("post.ai")
