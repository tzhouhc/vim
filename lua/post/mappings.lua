-- Keyboard Mapping Configurations, with Plugins

local key_utils = require("lib.key_utils")
local ufo = require("ufo")
local flash = require("flash")
local scopes = require("lib.scopes")

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
    -- move between change hunks
    ["[c"] = key_utils.prev_hunk,
    ["]c"] = key_utils.next_hunk,

    -- buffer movement
    ["<leader>1"] = "<Cmd>BufferLineGoToBuffer 1<CR>",
    ["<leader>2"] = "<Cmd>BufferLineGoToBuffer 2<CR>",
    ["<leader>3"] = "<Cmd>BufferLineGoToBuffer 3<CR>",
    ["<leader>4"] = "<Cmd>BufferLineGoToBuffer 4<CR>",
    ["<leader>5"] = "<Cmd>BufferLineGoToBuffer 5<CR>",
    ["<leader>6"] = "<Cmd>BufferLineGoToBuffer 6<CR>",
    ["<leader>7"] = "<Cmd>BufferLineGoToBuffer 7<CR>",
    ["<leader>8"] = "<Cmd>BufferLineGoToBuffer 8<CR>",
    ["<leader>9"] = "<Cmd>BufferLineGoToBuffer 9<CR>",
    ["<leader>$"] = "<Cmd>BufferLineGoToBuffer -1<CR>",

    -- Telescope

    -- local files
    ["<c-o>"] = ":Telescope find_files<cr>",
    -- files in the entire repo
    ["<m-o>"] = key_utils.local_or_repo_files,
    -- files in the repo that have changed
    ["<m-p>"] = ":ChangedInRepo<cr>",
    -- lines in current buffer
    ["<c-f>"] = ":Telescope current_buffer_fuzzy_find<cr>",
    -- lines across the repo
    ["<m-g>"] = scopes.live_grep_across_repo,
    -- lines in all local dir files
    ["<c-g>"] = ":Telescope live_grep<cr>",
    -- local symbols based on treesitter
    ["<c-k>"] = ":Telescope treesitter<cr>",
    -- local symbols based on LSP symbols
    ["<m-k>"] = ":Telescope lsp_document_symbols<cr>",
    -- git changes
    ["<c-p>"] = ":Telescope oldfiles<cr>",

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
  },
  -- selection by textobject
  [{ "o", "x" }] = {
    ["ih"] = ":<C-U>Gitsigns select_hunk<CR>",
  }
}

require("lib.misc").batch_set_keymap(key_configs)
