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
