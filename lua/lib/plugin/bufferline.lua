-- Hydra special mode keymappings
local Hydra = require("hydra")

Hydra({
  name = "Buffer",
  mode = "n",
  body = "<leader>b",
  hint = [[ _[_ Prev _]_ Next ]],
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
    {"[", "<cmd>bprev<cr>", {}},
    {"]", "<cmd>bnext<cr>", {}},
    { "<esc>", nil, { exit = true } },
  },
})
