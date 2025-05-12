-- Custom Commands
local misc = require("lib.misc")
local terms = require("lib.terms")
local tools = require("lib.tools")
local lazygit = require("snacks.lazygit")
local rename = require("snacks.rename")
local tree = require("lib.tree")

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
vim.api.nvim_create_user_command("FormatCode", tools.smart_format, { range = true })

-- Popup terminals
vim.api.nvim_create_user_command("Seb", terms.global_file_list, { range = true })

-- Git Tools
vim.api.nvim_create_user_command("Git", function() lazygit.open() end, {})
vim.api.nvim_create_user_command("GitLinesLogs", terms.git_lines_log, { range = true })
vim.api.nvim_create_user_command("GitLinesBlame", terms.git_lines_blame, { range = true })

-- Others
vim.api.nvim_create_user_command("FloatRight", terms.right_side_term, {})
vim.api.nvim_create_user_command("F", "FzfLua", { nargs = "?" })
vim.api.nvim_create_user_command("Scratch", misc.make_scratch, {})

-- Snacks
vim.api.nvim_create_user_command("RenameFile", rename.rename_file, {})

-- Treesitter
vim.api.nvim_create_user_command("PrintTSNode", tree.print_cur_node, {})
