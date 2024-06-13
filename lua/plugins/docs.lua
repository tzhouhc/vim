return {
	{
		-- query Devdocs inside vim
		"tzhouhc/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = "DevdocsOpenCurrentFloat",
		opts = {
			wrap = true,
			previewer_cmd = "bat",
			cmd_args = { "-p" },
			picker_cmd = "bat",
			picker_cmd_args = { "-p" },
			after_open = function(_)
				vim.cmd("set statuscolumn=")
				vim.cmd("set ft=markdown")
			end,
		},
	},
}
