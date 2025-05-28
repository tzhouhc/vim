-- Utilities dealing with input methods. Mainly relevant with available IME
-- switching API.

vim.g.en_ime = "com.apple.keylayout.US"
vim.g.cn_ime = "im.rime.inputmethod.Squirrel.Hans"
local edit = require("lib.editing")

local M = {}

function M.switch_to_en_ime()
  vim.fn.execute("!/opt/homebrew/bin/macism " .. vim.g.en_ime .. " &>/dev/null", "silent!")
end

function M.switch_to_cn_ime()
  vim.fn.execute("!/opt/homebrew/bin/macism " .. vim.g.cn_ime .. " &>/dev/null", "silent!")
end

-- check previous character; if start of line, check previous line.
function M.context_is_cn()
  local char = edit.get_char_at_cursor(-1, true)
  return char >= "\x80"
end

return M
