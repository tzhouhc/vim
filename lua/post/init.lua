-- Plugins Post-Setups
-- Here are the more complicated setups for plugins that cannot be done
-- directly via the `opts` in lazy loading.

-- rainbow delimiter and indentation
require("post.rainbow")
-- highlighting and other visual effects
require("post.visuals")
-- errors, hints, etc
require("post.diagnostics")
-- language services
require("post.lsp")
-- completions via blink-cmp
require("post.cmp")
-- custom commands
require("post.commands")
