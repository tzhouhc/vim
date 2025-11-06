local M = {}

-- conditional autocmds with toggle commands. Useful for all autocmds that have
-- a global boolean toggle key.
-- NOTE: create_autocmd should handle creating the autogroup with the name.
function M.create_toggleable_autocmd(global_key, create_autocmd, name)
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

return M
