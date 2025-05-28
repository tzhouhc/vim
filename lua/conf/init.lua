-- General configurations
-- These settings are related largely to vim-native and do not error out if
-- any plugins failed to load.

-- unchecked-in configs and their default values
require("conf.local_defaults")
-- local might not exist; which is fine!
pcall(require("conf.local"))
-- visual effects
require("conf.visuals")
-- autocommands
require("conf.autocmds")
-- Popup menu items
require("conf.menus")
-- vim opts
require("conf.settings")
-- errors, hints, etc
require("conf.diagnostics")
-- keymaps
require("conf.mappings")
-- filetypes recognition
require("conf.files")
-- override neovim native components
require("conf.overrides")
