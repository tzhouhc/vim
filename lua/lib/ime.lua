-- Utilities dealing with input methods. Mainly relevant with available IME
-- switching API.

vim.g.en_ime = "com.apple.keylayout.US"
vim.g.cn_ime = "im.rime.inputmethod.Squirrel.Hans"

local autogrp_name = "AutoSwitchInputMethod"
local edit = require("lib.editing")

local M = {}
M.insert_lang = "en"

local function switch_to_en_ime()
  vim.fn.execute("!/opt/homebrew/bin/macism " .. vim.g.en_ime .. " &>/dev/null", "silent!")
end

local function switch_to_cn_ime()
  vim.fn.execute("!/opt/homebrew/bin/macism " .. vim.g.cn_ime .. " &>/dev/null", "silent!")
end

local function is_using_cn_ime()
  local result = vim.fn.execute("!/opt/homebrew/bin/macism", "silent!")
  if string.find(result, vim.g.cn_ime) then
    return true
  end
  return false
end

-- check previous character; if start of line, check previous line.
local function context_is_cn()
  local char = edit.get_char_at_cursor(-1, true)
  return char >= "\x80"
end

function M.create_autocmds()
  local autogrp = vim.api.nvim_create_augroup(autogrp_name, { clear = true })
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
      if is_using_cn_ime() then
        M.insert_lang = "cn"
        switch_to_en_ime()
      else
        M.insert_lang = "en"
      end
    end,
    group = autogrp,
  })

  vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    callback = function()
      if M.insert_lang == "cn" then
        switch_to_cn_ime()
      end
    end,
    group = autogrp,
  })
end

function M.remove_autocmds()
  vim.api.nvim_del_augroup_by_name(autogrp_name)
end

vim.api.nvim_create_user_command("AutoSwitchInputMethodToggle", function()
  if vim.g.auto_toggle_ime then
    vim.g.auto_toggle_ime = false
    M.remove_autocmds()
  else
    vim.g.auto_toggle_ime = true
    M.create_autocmds()
  end
end, { range = true })

return M
