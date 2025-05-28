-- Plugins Post-Setups

-- Here are the more complicated setups for plugins that cannot be done
-- directly via the `opts` in lazy loading, but still needs to be loaded and
-- *run* once. (Otherwise the code will belong in `lib`, where they can but
-- won't necessarily be called by a dependent plugin/cmd)

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
