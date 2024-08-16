return {
  -- 'tabs'
  {
    "akinsho/bufferline.nvim",
    config = function()
      local conf
      if vim.g.theme == "catppuccin" then
        conf = {
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
          options = {
            show_buffer_close_icons = false,
          },
        }
      else
      end
      require("bufferline").setup({
        options = {
          show_buffer_close_icons = false,
        },
      })
    end,
  },
}
