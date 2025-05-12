-- Keyboard Mapping Configurations, with Plugins

local key_utils = require("lib.key_utils")

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
  -- Normal mode
  n = {
  },
  -- Visual mode
  v = {
  },
  [{ "n", "v" }] = {
  },
  [{ "i", "s" }] = {
  },
}

require("lib.misc").batch_set_keymap(key_configs)
