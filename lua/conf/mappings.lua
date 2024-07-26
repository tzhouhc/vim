-- Keyboard Mapping Configurations

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
  -- Normal mode
  n = {
    -- cancel search/flash highlight
    ["<esc>"] = "<esc>:noh<CR>",
    -- close all non-main windows
    ["<leader><esc>"] = ":only<CR>",
    -- close this window
    ["<m-esc>"] = ":q<CR>",
    -- leader actions
    ["<leader>ev"] = ":e $MYVIMRC<cr>",
    ["<leader>en"] = ":e $HOME/.notes<cr>",

    -- buffer movement
    ["[b"] = ":bprev<cr>",
    ["]b"] = ":bnext<cr>",
    ["<PageUp>"] = ":bprev<cr>",
    ["<PageDown>"] = ":bnext<cr>",
    ["[t"] = ":tabp<cr>",
    ["]t"] = ":tabn<cr>",

    -- tmux-like splitting
    ["<c-w>%"] = ":vsplit<cr>",
    ['<c-w>"'] = ":split<cr>",
    ["<c-w>z"] = ":only<cr>",
    -- alternate window movement
    ["[w"] = "<c-w><left>",
    ["]w"] = "<c-w><right>",
    -- quicklist movement
    ["[q"] = ":cprev<cr>",
    ["]q"] = ":cnext<cr>",
    ["[Q"] = ":cfirst<cr>",
    ["]Q"] = ":clast<cr>",
  },
  -- Visual mode
  v = {
    -- select whole words by default
    ["w"] = "iw",
    ["W"] = "iW",
    [")"] = "i)",
    ["]"] = "i]",
    ['"'] = 'i"',

    -- replace currently selected text with default register
    -- without yanking it.
    ["p"] = '"_dP',
  },
  [{ "n", "v" }] = {
    -- faster movement
    ["<c-Up>"] = "10k",
    ["<c-Down>"] = "10j",
    -- better cutting (`x` no longer yanks due to cutlass,
    -- but it doesn't delete the whole line.)
    ["X"] = '"_dd',
  },
  [{ "i", "s" }] = {
    -- enter new line but don't keep commenting if currently in comment block
    ["<s-cr>"] = "<esc>o<esc>cc",
  },
  -- Terminal mode
  t = {
    -- terminal mode exit
    ["<c-w><esc>"] = "<C-\\><C-n>",
  },
  ca = {
    ["bd"] = "BD!",
    ["waq"] = "wa | q",
  }
}

require("lib.misc").batch_set_keymap(key_configs)
