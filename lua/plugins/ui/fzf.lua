return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      local fzf = require("fzf-lua")
      fzf.setup({})

      local key_configs = {
        n = {
          -- local files
          ["<c-o>"] = ":FzfLua files<cr>",
          -- lines in current buffer
          ["<c-f>"] = ":FzfLua blines<cr>",
          -- lines across the repo
          ["<m-f>"] = ":FzfLua live_grep<cr>",
          -- local symbols based on treesitter
          ["<c-k>"] = ":FzfLua treesitter<cr>",
          -- local symbols based on LSP symbols
          ["<m-k>"] = ":FzfLua lsp_document_symbols<cr>",
          -- git changes
          ["<c-p>"] = ":FzfLua oldfiles<cr>",
					-- use telescopes for registers invocation instead
					["<leader>p"] = ":FzfLua registers<cr>",
        },
				v = {
					["<leader>p"] = ":FzfLua registers<cr>",
				}
      }

			-- commands
			vim.api.nvim_create_user_command("Registers", "FzfLua registers", {})
			vim.api.nvim_create_user_command("Highlights", "FzfLua highlights", {})
			vim.api.nvim_create_user_command("Manpages", "FzfLua manpages", {})

      require("lib.misc").batch_set_keymap(key_configs)

    end
  }
}
