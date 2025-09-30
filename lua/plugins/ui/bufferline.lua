return {
  -- 'tabs'
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
      local keymap = {
        n = {
          -- buffer movement
          ["g1"] = "<cmd>BufferLineGoToBuffer 1<CR>",
          ["g2"] = "<cmd>BufferLineGoToBuffer 2<CR>",
          ["g3"] = "<cmd>BufferLineGoToBuffer 3<CR>",
          ["g4"] = "<cmd>BufferLineGoToBuffer 4<CR>",
          ["g5"] = "<cmd>BufferLineGoToBuffer 5<CR>",
          ["g6"] = "<cmd>BufferLineGoToBuffer 6<CR>",
          ["g7"] = "<cmd>BufferLineGoToBuffer 7<CR>",
          ["g8"] = "<cmd>BufferLineGoToBuffer 8<CR>",
          ["g9"] = "<cmd>BufferLineGoToBuffer 9<CR>",
          ["g0"] = "<cmd>BufferLineGoToBuffer -1<CR>",
        }
      }
      require("lib.binder").batch_set_keymap(keymap)
      require("lib.plugin.bufferline")
    end,
  },
}
