if vim.g.theme == "catppuccin" then
  require("bufferline").setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
		options = {
			show_buffer_close_icons = false,
		},
  }
else
  require("bufferline").setup({
		options = {
			show_buffer_close_icons = false,
		},
	})
end
