-- Custom Commands
--
-- Note that we now strive to only keep non-plugin-based commands here -- any
-- commands that depends on a plugin should be defined within the plugin's
-- config function so as to be lazy-loaded alongside. If a command depends on
-- multiple plugins, then inter-plugin dependencies should be declared first,
-- then the command be associated with the "primary" plugin.

local misc = require("lib.misc")

-- Tooling shortcuts
vim.api.nvim_create_user_command("GetPluginLink", misc.get_current_line_plugin, {})
vim.api.nvim_create_user_command("Scratch", misc.make_scratch, {})
