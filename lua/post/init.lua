-- Plugins Post-Setups
-- Here are the more complicated setups for plugins that cannot be done
-- directly via the `opts` in lazy loading.

-- visual theme
require("post.theme")
-- startup page
require("post.startup")
-- key mappings using plugins
require("post.mappings")
-- telescope fuzzy selection
require("post.telescope")
-- rainbow delimiter and indentation
require("post.rainbow")
-- highlighting and other visual effects
require("post.visuals")
-- highlighting and other visual effects
require("post.bufferline")
-- lualine customization
require("post.lualine")
-- errors, hints, etc
require("post.diagnostics")
-- language services
require("post.lsp")
-- completions via nvim-cmp
require("post.completions")
-- commander
require("post.commands")
