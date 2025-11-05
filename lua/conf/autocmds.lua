-- Autocommand Setup

local ime = require("lib.ime")

-- conditional autocmds with toggle commands. Useful for all autocmds that have
-- a global boolean toggle key.
-- NOTE: create_autocmd should handle creating the autogroup with the name.
local function create_toggleable_autocmd(global_key, create_autocmd, name)
	local cmd_name = name .. "Toggle"

	-- create should usually succeed, but delete *might* happen if the option
	-- is false by default.
	local function remove_autogrp()
		pcall(vim.api.nvim_del_augroup_by_name, name)
	end

	local function setup()
		if not not vim.g[global_key] then
			create_autocmd()
		else
			remove_autogrp()
		end
	end

	local function toggle()
		vim.g[global_key] = not vim.g[global_key]
		setup()
	end

	setup()
	vim.api.nvim_create_user_command(cmd_name, toggle, {})
end

-- on save, clean all trailing whitespaces.
create_toggleable_autocmd("auto_cleanup_whitespace", function()
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			vim.api.nvim_command(":FixWhitespace")
		end,
		group = vim.api.nvim_create_augroup("AutoFixWhitespace", { clear = true }),
	})
end, "AutoFixWhitespace")

-- on save, detect filetype if not set yet
create_toggleable_autocmd("detect_filetype_on_save", function()
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			if vim.bo.filetype == "" then
				vim.cmd(":filetype detect")
			end
		end,
		group = vim.api.nvim_create_augroup("AutoDetectFiletype", { clear = true }),
	})
end, "AutoDetectFiletype")

-- use EN IME on leaving Insert
create_toggleable_autocmd("auto_toggle_ime", ime.create_autocmds, ime.autogrp_name)

-- write oldfiles to disk before exiting vim
if vim.g.save_old_files then
	vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
		callback = function()
			vim.cmd("redir >> /tmp/oldfiles.txt | silent oldfiles | redir end")
		end,
		group = vim.api.nvim_create_augroup("RecordOldFiles", { clear = true }),
	})
end

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "sql",
	callback = function()
		vim.keymap.del("i", "<left>", { buffer = true })
		vim.keymap.del("i", "<right>", { buffer = true })
	end,
	group = vim.api.nvim_create_augroup("RemoveSqlKeymapQuirk", { clear = true }),
})

-- use help tags as if they are LSP symbols and jump using `g;`
local help_binds = {
	n = {
		["gd"] = "<c-]>",
		["g;"] = "<c-o>",
	},
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("HelpMappings", { clear = true }),
	callback = function(args)
		local bufnr = args.buf
		local filetype = vim.bo[bufnr].filetype
		if filetype == "help" then
			require("lib.binder").batch_set_buf_keymap(help_binds)
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*custom_phrase.txt", -- Replace with your desired filename
	callback = function()
		vim.bo.filetype = "tsv" -- Replace with your desired filetype
		vim.bo.expandtab = false
		vim.bo.tabstop = 8
		vim.bo.shiftwidth = 8
	end,
})

-- Todo list custom tooling
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*tasks.md", -- Replace with your desired filename
	callback = function()
		vim.keymap.set("n", "gt", require("lib.tasks").toggle_todo_item, { noremap = true, silent = true })
	end,
})
