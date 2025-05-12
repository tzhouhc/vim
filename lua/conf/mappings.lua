-- Keyboard Mapping Configurations

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
}

require("lib.misc").batch_set_keymap(key_configs)
