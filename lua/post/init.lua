-- Plugins Post-Setups
-- Here are the more complicated setups for plugins that cannot be done
-- directly via the `opts` in lazy loading.

-- key mappings using plugins
require("post.mappings")
-- rainbow delimiter and indentation
require("post.rainbow")
-- highlighting and other visual effects
require("post.visuals")
-- errors, hints, etc
require("post.diagnostics")
-- language services
require("post.lsp")
-- completions via nvim-cmp
require("post.completions")
-- custom commands
require("post.commands")
