-- Keyboard Mapping Configurations

-- editing utilities written in lua that do not depend on plugins
local edit = require("lib.editing")

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
    ["<leader>ql"] = edit.toggle_quickfix,

    -- tab cycles windows
    ["<tab>"] = "<c-w>w",

    -- disable cmdline window
    ["q:"] = "",

    -- mimic right mouse
    ["g<space>"] = "<cmd>popup PopUp<cr>",

    -- diagnostics movement
    ["[e"] = function() vim.diagnostic.jump({ count = -1 }) end,
    ["]e"] = function() vim.diagnostic.jump({ count = 1 }) end,
    -- create empty lines without moving
    ["[<space>"] = edit.add_blank_line_before,
    ["]<space>"] = edit.add_blank_line_after,

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

    -- increment/decrement number
    ["+"] = "<c-a>",
    ["-"] = "<c-x>",

    -- smarter shift I
    ["I"] = edit.smarter_shift_i,
  },
  -- Visual mode
  v = {
    -- select whole words by default
    ["w"] = "iw",
    ["W"] = "iW",

    -- replace currently selected text with default register
    -- without yanking it.
    ["p"] = '"_dP',

    ["/"] = edit.search_selected,
  },
  [{ "n", "v" }] = {
    -- faster movement
    ["<c-Up>"] = "10k",
    ["<c-Down>"] = "10j",
    -- better cutting (`x` no longer yanks due to cutlass,
    -- but it doesn't delete the whole line.)
    ["X"] = '"_dd',
    -- jump to first position after the first space (to avoid comment prefixes).
    ["0"] = edit.alternating_zero,
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
    ["waq"] = "wa | q",
  }
}

require("lib.binder").batch_set_keymap(key_configs)
