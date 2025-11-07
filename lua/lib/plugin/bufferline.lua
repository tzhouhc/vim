-- Hydra special mode keymappings
local Hydra = require("hydra")

Hydra({
  name = "Buffer",
  mode = "n",
  body = "<leader>b",
  hint = [[ _[_ Prev _]_ Next _<_ Swap Left _>_ Swap Right _X_ Close Others _x_ Close ]],
  config = {
    color = "red",
    invoke_on_body = true,
    timeout = false, -- by default hydras wait forever
    hint = {
      type = "statusline",
      show_name = true,
    },
  },
  heads = {
    {"1", "<cmd>BufferLineGoToBuffer 1<CR>", {}},
    {"2", "<cmd>BufferLineGoToBuffer 2<CR>", {}},
    {"3", "<cmd>BufferLineGoToBuffer 3<CR>", {}},
    {"4", "<cmd>BufferLineGoToBuffer 4<CR>", {}},
    {"5", "<cmd>BufferLineGoToBuffer 5<CR>", {}},
    {"6", "<cmd>BufferLineGoToBuffer 6<CR>", {}},
    {"7", "<cmd>BufferLineGoToBuffer 7<CR>", {}},
    {"8", "<cmd>BufferLineGoToBuffer 8<CR>", {}},
    {"9", "<cmd>BufferLineGoToBuffer 9<CR>", {}},
    {"0", "<cmd>BufferLineGoToBuffer -1<CR>", {}},
    {"[", "<cmd>BufferLineCyclePrev<cr>", {}},
    {"]", "<cmd>BufferLineCycleNext<cr>", {}},
    {"<", function()
      vim.cmd("BufferLineMovePrev")
      vim.cmd("redraw!")
    end, {}},
    {">", function()
      vim.cmd("BufferLineMoveNext")
      vim.cmd("redraw!")
    end, {}},
    {"x", function()
      vim.cmd("bd")
      vim.cmd("redraw!")
    end, {}},
    {"X", function()
      vim.cmd("BufferLineCloseOthers")
      vim.cmd("redraw!")
    end, {}},
    { "<esc>", nil, { exit = true } },
  },
})
