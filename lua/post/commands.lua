-- Custom Commands
local misc = require("lib.misc")
local terms = require("lib.terms")
local popups = require("lib.popups")
local tools = require("lib.tools")
local lazygit = require("snacks.lazygit")
local rename = require("snacks.rename")
local ts = require("telescope.builtin")

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
-- Git Tools
vim.api.nvim_create_user_command("Git", function() lazygit.open() end, {})
vim.api.nvim_create_user_command("GitLinesLogs", terms.git_lines_log, { range = true })
vim.api.nvim_create_user_command("GitLinesBlame", terms.git_lines_blame, { range = true })

-- Others
vim.api.nvim_create_user_command("FloatRight", terms.right_side_term, {})
vim.api.nvim_create_user_command("H", popups.help_popup, { nargs = "?", complete = "help" })
vim.api.nvim_create_user_command("Scratch", misc.make_scratch, {})

-- Snacks
vim.api.nvim_create_user_command("RenameFile", rename.rename_file, {})

-- Diagnostics
vim.api.nvim_create_user_command("Diagnostics", "Trouble diagnostics win.type=split win.position=right win.size.width=80", {})

-- Telescopes
vim.api.nvim_create_user_command("Symbols", ts.lsp_document_symbols, {})
vim.api.nvim_create_user_command("WorkspaceSymbols", ts.lsp_workspace_symbols, {})
vim.api.nvim_create_user_command("Registers", ts.registers, {})
vim.api.nvim_create_user_command("Highlights", ts.highlights, {})
vim.api.nvim_create_user_command("Manpages", ts.man_pages, {})

