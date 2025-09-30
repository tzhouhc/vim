local misc = require("lib.misc")

_G.dump = function(o)
  vim.notify("\n" .. misc.dump(o), vim.log.levels.DEBUG)
end

vim.api.nvim_create_user_command("ExecuteSelected", function(opts)
  -- Only proceed if current filetype is Lua
  if vim.bo.filetype ~= "lua" then return end

  -- Get visual selection range
  local line1 = opts.line1
  local line2 = opts.line2
  if not (line1 and line2) then return end

  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  local code = table.concat(lines, "\n")

  local f, err = load(code)
  if not f then
    vim.notify("ExecuteSelected: Load error: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  local ok, exec_err = pcall(f)
  if not ok then
    vim.notify("ExecuteSelected: Runtime error: " .. tostring(exec_err), vim.log.levels.ERROR)
  end
end, { range = true, desc = "Execute visually selected Lua code" })

-- Hydra special mode keymappings
local Hydra = require("hydra")
local dap = require("dap")

Hydra({
  -- string? only used in auto-generated hint
  name = "Debug",
  -- string | string[] modes where the hydra exists, same as `vim.keymap.set()` accepts
  mode = "n",
  -- string? key required to activate the hydra, when excluded, you can use
  -- Hydra:activate()
  body = "<leader>db",

  -- these are explained below
  hint = [[ _b_ Toggle Breakpoint _c_ Continue _s_ Step Into _o_ Step Over ]],
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
    on_enter = function()
      print('Debug keymap activated.')
    end,
    on_exit = function()
      print('Debug keymap deactivated.')
    end,
    on_key = nil, -- called after every hydra head

    -- timeout after which the hydra is automatically disabled. Calling any head
    -- will refresh the timeout
    --   true: timeout set to value of 'timeoutlen' (:h 'timeoutlen')
    --   5000: set to desired number of milliseconds
    timeout = false, -- by default hydras wait forever

    -- see :h hydra-hint-hint-configuration
    hint = {
      type = "statusline",
    },
  },
  heads = {
    { "b",          dap.toggle_breakpoint, {} },
    { "c",          dap.continue,          {} },
    { "s",          dap.step_into,         {} },
    { "o",          dap.step_over,         {} },
    { "<leader>db", nil,                   { exit = true } },
  },
})
