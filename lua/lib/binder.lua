-- Utilities for batch setting keymaps, optionally creating autocmds to
-- associate them with individual buffers.

local M = {}

---Batch set mappings. Expects a table where the top level are tables keyed by
---modes, and tables contain lhs string keys to rhs string or function values;
---second table contains opts to be set for each keymap.
---@param mappings table
---@param opt table
local function do_batch_set_keymap(mappings, opt)
  for mode, conf in pairs(mappings) do
    for key, val in pairs(conf) do
      if type(val) == "string" or type(val) == "function" then
        -- default configuration
        vim.keymap.set(mode, key, val, opt)
      else
        local command, opts = table.unpack(val)
        vim.keymap.set(mode, key, command, opts)
      end
    end
  end
end

---Set keymap globally.
function M.batch_set_keymap(mappings)
  do_batch_set_keymap(mappings, { noremap = true, silent = true })
end

---Set keymap local to the buffer.
function M.batch_set_buf_keymap(mappings)
  do_batch_set_keymap(mappings, { noremap = true, silent = true, buffer = 0 })
end

function M.batch_set_auto_buf_keymap(mappings, suffix)
  local fts = require("lib.ft")
  local grp = vim.api.nvim_create_augroup("NormalBufferMappings-" .. suffix, { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = grp,
    callback = function(args)
      local bufnr = args.buf
      if not fts.is_normal_buffer(bufnr) then
        return
      end
      M.batch_set_buf_keymap(mappings)
    end,
  })
end

return M
