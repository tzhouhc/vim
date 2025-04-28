return {
  -- 'tabs'
  {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
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
        conf = {
          options = {
            show_buffer_close_icons = false,
          },
        }
      end
      require("bufferline").setup(conf)
    end,
  },
}
