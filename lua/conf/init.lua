-- General configurations
-- These settings are related largely to vim-native and do not error out if
-- any plugins failed to load.

-- Read environment and make corresponding changes
require("conf.env")

-- `local` contains unchecked-in configs, with default values stored in
-- `local_defaults`. Defaults need to be loaded once since some defaults are
-- true.
require("conf.local_defaults")
-- When loading, `local` might not exist; this is fine!
-- If unable to import `conf.local` just copy local_defaults to it. This
-- makes subsequent editing easier.
local succ, _ = pcall(require, "conf.local")
if not succ then
  local default_file = vim.fs.joinpath(vim.g.vim_home, "lua/conf/local_defaults.lua")
  local local_file = vim.fs.joinpath(vim.g.vim_home, "lua/conf/local.lua")
	io.popen("cp " .. default_file .. " " .. local_file)
end

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
