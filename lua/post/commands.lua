-- Custom Commands
local misc = require("lib.misc")
local terms = require("lib.terms")
local tools = require("lib.tools")

-- Tooling shortcuts
vim.api.nvim_create_user_command("GetPluginLink", misc.get_current_line_plugin, {})
vim.api.nvim_create_user_command("FormatCode", tools.smart_format, { range = true })

-- Popup terminals
vim.api.nvim_create_user_command("Seb", terms.global_file_list, { range = true })

-- Git Tools
vim.api.nvim_create_user_command("GitLinesLogs", terms.git_lines_log, { range = true })
vim.api.nvim_create_user_command("GitLinesBlame", terms.git_lines_blame, { range = true })

-- Others
vim.api.nvim_create_user_command("FloatRight", terms.right_side_term, {})

vim.api.nvim_create_user_command("F", "FzfLua", { nargs = "?" })
vim.api.nvim_create_user_command("Scratch", misc.make_scratch, {})

-- Snacks
