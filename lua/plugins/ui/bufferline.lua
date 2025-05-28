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
          -- WARN: not working?
          ["<c-1>"] = "<cmd>BufferLineGoToBuffer 1<CR>",
          ["<c-2>"] = "<cmd>BufferLineGoToBuffer 2<CR>",
          ["<c-3>"] = "<cmd>BufferLineGoToBuffer 3<CR>",
          ["<c-4>"] = "<cmd>BufferLineGoToBuffer 4<CR>",
          ["<c-5>"] = "<cmd>BufferLineGoToBuffer 5<CR>",
          ["<c-6>"] = "<cmd>BufferLineGoToBuffer 6<CR>",
          ["<c-7>"] = "<cmd>BufferLineGoToBuffer 7<CR>",
          ["<c-8>"] = "<cmd>BufferLineGoToBuffer 8<CR>",
          ["<c-9>"] = "<cmd>BufferLineGoToBuffer 9<CR>",
          ["<c-0>"] = "<cmd>BufferLineGoToBuffer -1<CR>",
        }
      }
      require("lib.binder").batch_set_keymap(keymap)
    end,
  },
}
