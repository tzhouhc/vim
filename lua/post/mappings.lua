-- Keyboard Mapping Configurations, with Plugins

local key_utils = require("lib.key_utils")
local ufo = require("ufo")
local flash = require("flash")

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
  -- Normal mode
  n = {
    ["<leader>ft"] = ":NvimTreeToggle<CR>",
    ["<leader>q"] = ":BD<cr>",
    ["<leader>ql"] = key_utils.toggle_quickfix,
    ["<leader>dd"] = ":DevdocsOpenCurrentFloat<cr>",
    ["<leader>lg"] = ":Git<cr>",
    ["<leader>ar"] = ":AerialToggle!<cr>",

    -- trouble
    ["<leader>tr"] = ":Trouble diagnostics toggle filter.buf=0<cr>",

    -- diffview
    ["<leader>dv"] = key_utils.toggle_diffview,

    -- use telescopes for registers invocation instead
    ["<leader>p"] = ":Telescope registers<cr>",

    -- trouble movement
    ["[e"] = key_utils.jump_to_prev_trouble_item,
    ["]e"] = key_utils.jump_to_next_trouble_item,
    -- create empty lines without moving
    ["[<space>"] = key_utils.add_blank_line_before,
    ["]<space>"] = key_utils.add_blank_line_after,

    -- Telescope
    -- for local files and local tags
    ["<c-o>"] = ":Telescope find_files<cr>",
    ["<m-o>"] = key_utils.local_or_repo_files,
    ["<m-p>"] = ":Easypick changed_files<cr>",
    -- lines in current buffer
    ["<c-f>"] = ":Telescope current_buffer_fuzzy_find<cr>",
    -- lines in all local files
    ["<c-g>"] = ":Telescope live_grep<cr>",
    -- local symbols based on treesitter
    ["<c-k>"] = ":Telescope treesitter<cr>",
    -- local symbols based on ctags
    ["<m-k>"] = ":Telescope tags<cr>",
    -- git changes
    ["<c-p>"] = ":Telescope oldfiles<cr>",
    -- commander
    ["<m-space>"] = ":Telescope commander<cr>",

    -- folding
    ["zR"] = ufo.openAllFolds,
    ["zM"] = ufo.closeAllFolds,

    -- smarter shift I
    ["I"] = key_utils.smarter_shift_i,
    ["<m-i>"] = key_utils.smart_move_to_start_and_insert,
  },
  -- Visual mode
  v = {
    -- same as normal but also does a non-yanking deletion first
    ["<leader>p"] = '"_d<esc>:Telescope registers<cr>',
  },
  [{ "n", "v" }] = {
    -- meta+f to select and go to one specific letter on screen
    ["<m-f>"] = flash.jump,
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
  }
}

require("lib.misc").batch_set_keymap(key_configs)
