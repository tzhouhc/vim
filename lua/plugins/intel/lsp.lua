return {
	-- LSPs
	"neovim/nvim-lspconfig",
	{ "onsails/lspkind.nvim",    event = "LspAttach" },

	-- mason
	{ "williamboman/mason.nvim", cmd = "Mason",      config = true },
	"williamboman/mason-lspconfig.nvim",
}
