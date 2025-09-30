-- Library code dedicated to handling debugging.

-- Hydra special mode keymappings
local Hydra = require("hydra")
local dap = require("dap")
local dapui = require("dapui")

local debug_hydra = Hydra({
  -- string? only used in auto-generated hint
  name = "Debug",
  -- string | string[] modes where the hydra exists, same as `vim.keymap.set()` accepts
  mode = "n",
  -- string? key required to activate the hydra, when excluded, you can use
  -- Hydra:activate()
  body = "<leader>db",

  -- these are explained below
  hint = [[ _b_ Toggle Breakpoint _c_ Continue _s_ Step Over _i_ Step Into\n _o_ Step Out _C_ Clear Breakpoints ]],
  config = {
    -- see :h hydra-heads
    exit = false, -- set the default exit value for each head in the hydra

    -- decides what to do when a key which doesn't belong to any head is pressed
    --   nil: hydra exits and foreign key behaves normally, as if the hydra wasn't active
    --   "warn": hydra stays active, issues a warning and doesn't run the foreign key
    --   "run": hydra stays active, runs the foreign key
    foreign_keys = "run",
    color = "pink",

    -- when true, summon the hydra after pressing only the `body` keys. Normally a head is
    -- required
    invoke_on_body = true,

    -- description used for the body keymap when `invoke_on_body` is true
    desc = nil, -- when nil, "[Hydra] .. name" is used

    -- see :h hydra-hooks
    on_enter = nil,
    on_exit = nil,
    on_key = nil, -- called after every hydra head

    -- timeout after which the hydra is automatically disabled. Calling any head
    -- will refresh the timeout
    --   true: timeout set to value of 'timeoutlen' (:h 'timeoutlen')
    --   5000: set to desired number of milliseconds
    timeout = false, -- by default hydras wait forever

    -- see :h hydra-hint-hint-configuration
    hint = {
      type = "window",
      position = "top-right",
      offset = 1,
      show_name = true,
    },
  },
  heads = {
    { "b", dap.toggle_breakpoint, {} },
    { "c", dap.continue,          {} },
    { "s", dap.step_over,         {} },
    { "i", dap.step_into,         {} },
    { "o", dap.step_out,          {} },
    { "C", function()
      vim.ui.select(
        { "y", "n" }, { prompt = "Clear all breakpoints? ", }, function(item)
          if item == "y" then
            dap.clear_breakpoints()
          end
        end)
    end, {} },
    { "<leader>db", nil, { exit = true } },
  },
})

-- One command to do it all:
--   - open DAP UI
--   - start a new DAP session
--   - activate debug hydra
vim.api.nvim_create_user_command("Debugger", function()
  dapui.open()
  dap.continue()
  -- If no debug session is active, `continue()` will start a new debug
  -- session
  debug_hydra:activate()
end, {})
