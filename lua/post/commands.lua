-- Custom Commands
local misc = require("lib.misc")
local terms = require("lib.terms")
local popups = require("lib.popups")

vim.api.nvim_create_user_command("SelectSession", function()
  require("persistence").select()
end, {})
vim.api.nvim_create_user_command("SessionLoadLast", function()
  require("persistence").load({ last = true })
end, {})
vim.api.nvim_create_user_command("SessionLoadHere", function()
  require("persistence").load()
end, {})

-- Tooling shortcuts
vim.api.nvim_create_user_command("GetPluginLink", misc.get_current_line_plugin, {})
vim.api.nvim_create_user_command("FormatCode", function()
  vim.lsp.buf.format({ async = true })
end, {})

-- Popup terminals
vim.api.nvim_create_user_command("Git", terms.lazy_git, {})
vim.api.nvim_create_user_command("FloatRight", terms.right_side_term, {})
vim.api.nvim_create_user_command("H", popups.help_popup, { nargs = "?", complete = "help" })

vim.api.nvim_create_user_command("Scratch", misc.make_scratch, {})
