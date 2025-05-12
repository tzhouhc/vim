return {
	-- passives
	-- automatically close/add pairs
	{ "windwp/nvim-autopairs",           config = true,     event = { "BufReadPost", "BufNewFile", "BufWritePre" } },
	-- y/d/s for pairs at once
	{ "kylechui/nvim-surround",          config = true,     event = { "BufReadPost", "BufNewFile", "BufWritePre" } },
	-- removing trailing whitespace on save
	{ "bronson/vim-trailing-whitespace", event = { "BufReadPost", "BufNewFile", "BufWritePre" } },
	-- follow symlinks
	"aymericbeaumet/vim-symlink",
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
