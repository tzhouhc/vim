-- Keyboard Mapping Configurations, with Plugins

local key_utils = require("lib.key_utils")
local terms = require("lib.terms")

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
  -- Normal mode
  n = {
    ["<leader>q"] = ":BD<cr>",
    ["<leader>ql"] = key_utils.toggle_quickfix,
    ["<leader>lg"] = ":Git<cr>",
    ["<leader>ar"] = ":AerialToggle!<cr>",

    -- trouble
    ["<leader>tr"] = ":Trouble diagnostics toggle filter.buf=0<cr>",

    -- diffview
    ["<leader>dv"] = key_utils.toggle_diffview,

    -- quake term
    ["<m-e>"] = terms.quake_term,

    -- trouble movement
    ["[e"] = key_utils.jump_to_prev_trouble_item,
    ["]e"] = key_utils.jump_to_next_trouble_item,
    -- create empty lines without moving
    ["[<space>"] = key_utils.add_blank_line_before,
    ["]<space>"] = key_utils.add_blank_line_after,
    -- move between change hunks
    ["[c"] = key_utils.prev_hunk,
    ["]c"] = key_utils.next_hunk,

    -- buffer movement
    ["<c-1>"] = "<Cmd>BufferLineGoToBuffer 1<CR>",
    ["<c-2>"] = "<Cmd>BufferLineGoToBuffer 2<CR>",
    ["<c-3>"] = "<Cmd>BufferLineGoToBuffer 3<CR>",
    ["<c-4>"] = "<Cmd>BufferLineGoToBuffer 4<CR>",
    ["<c-5>"] = "<Cmd>BufferLineGoToBuffer 5<CR>",
    ["<c-6>"] = "<Cmd>BufferLineGoToBuffer 6<CR>",
    ["<c-7>"] = "<Cmd>BufferLineGoToBuffer 7<CR>",
    ["<c-8>"] = "<Cmd>BufferLineGoToBuffer 8<CR>",
    ["<c-9>"] = "<Cmd>BufferLineGoToBuffer 9<CR>",
    ["<c-0>"] = "<Cmd>BufferLineGoToBuffer -1<CR>",

    -- formatting
    ["<leader>fc"] = "<Cmd>FormatCode<cr>",

    -- smarter shift I
    ["I"] = key_utils.smarter_shift_i,
    ["<m-i>"] = key_utils.smart_move_to_start_and_insert,
  },
  -- Visual mode
  v = {
    -- formatting
    ["<leader>fc"] = "<Cmd>FormatCode<cr>",
  },
  [{ "n", "v" }] = {
    -- jump to first position after the first space (to avoid comment prefixes).
    ["0"] = key_utils.alternating_zero,
    -- jump to start of text object, be situationally aware
    ["<m-0>"] = key_utils.smart_move_to_start,
    ["<m-left>"] = key_utils.smart_move_to_start,
    ["<m-right>"] = key_utils.smart_move_to_end,
  },
  [{ "i", "s" }] = {
    -- fallback value of these commands are hardcoded to tab and s-tab, so
    -- change the corresponding func if changed here.
    ["<c-right>"] = { key_utils.vsnip_jump_forward, { expr = true } },
    ["<c-left>"] = { key_utils.vsnip_jump_backward, { expr = true } },
  },
  -- Terminal mode
  t = {
  },
  -- Command mode, abbrev
  ca = {
    ["h"] = "H",
  },
  -- selection by textobject
  [{ "o", "x" }] = {
    ["ih"] = ":<C-U>Gitsigns select_hunk<CR>",
  }
}

require("lib.misc").batch_set_keymap(key_configs)
