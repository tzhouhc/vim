return {
	-- visuals
	-- create vertical lines to mark indentation.
	"lukas-reineke/indent-blankline.nvim",
	-- icons
	(function()
		if os.getenv("NERDFONT") == "2" then
			return { "nvim-tree/nvim-web-devicons", tag = "nerd-v2-compat" }
		else
			return "nvim-tree/nvim-web-devicons"
		end
	end)(),
	-- scroll-bar for checking location in file
	{
		"petertriho/nvim-scrollbar",
		opts = {
			show_in_active_only = true,
			hide_if_all_visible = true, -- Hides everything if all lines are visible
			excluded_buftypes = {
				"terminal",
			},
			excluded_filetypes = {
				"",
				"cmp_docs",
				"cmp_menu",
				"noice",
				"prompt",
				"TelescopePrompt",
			},
		},
	},
	-- nord theme
	{
		-- the Neovim version of `nord` theme has better compatibility
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the color-scheme here
			vim.cmd([[colorscheme nord]])
		end,
	},
	-- rainbow colors for parentheses/brackets for easier depth determination
	"HiPhish/rainbow-delimiters.nvim",
	-- 'tabs'
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				show_buffer_close_icons = false,
			},
		},
	},
	-- highlight hex colors
	{ "norcalli/nvim-colorizer.lua", config = true, cmd = "ColorizerToggle" },
	-- mark unsaved changes in buffer in gutter; diffs pending changes
	"chrisbra/changesPlugin",
	-- add signs to gutter for marking diffs; only diffs written
	"mhinz/vim-signify",
	-- highlight TODOs
	{ "folke/todo-comments.nvim", config = true },
	-- smart dimming of unrelated contextual code
	{ "folke/twilight.nvim", config = true, cmd = "Twilight" },
	-- keep top of code context on screen when scrolling past
	"nvim-treesitter/nvim-treesitter-context",
	-- text objects
	"nvim-treesitter/nvim-treesitter-textobjects",
	-- highlight same token as the cursor is currently hovering over
	"RRethy/vim-illuminate",
	-- smarter folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		opts = {
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		},
	},
}
