vim.g.en_ime = "com.apple.keylayout.US"
vim.g.cn_ime = "im.rime.inputmethod.Squirrel.Hans"

local M = {}

function M.switch_to_en_ime()
  vim.fn.execute("!/opt/homebrew/bin/macism " .. vim.g.en_ime .. " &>/dev/null", "silent!")
end

function M.switch_to_cn_ime()
  vim.fn.execute("!/opt/homebrew/bin/macism " .. vim.g.cn_ime .. " &>/dev/null", "silent!")
end

return M
