-- Keyboard Mapping Configurations

vim.g.mapleader = "\\"

local safe_require = require('lib.meta').safe_require
local key_utils = safe_require('lib.key_utils')
local ufo = safe_require('ufo')
local flash = safe_require('flash')

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
  -- Normal mode
  n = {
    -- cancel search/flash highlight
    ["<esc>"] = "<esc>:noh<CR>",
    -- ==== leader actions ====
    ["<leader>ev"] = ":e $MYVIMRC<cr>",
    ["<leader>en"] = ":e $HOME/.notes<cr>",
    ["<leader>ft"] = ":NvimTreeToggle<CR>",
    ["<leader>q"] = ":BD<cr>",
    ["<leader>dd"] = ":DevdocsOpenCurrentFloat<cr>",

    -- lsp actions
    ["<leader>fc"] = ':LspZeroFormat<cr>',
    ["<leader>rn"] = '<cmd>lua vim.lsp.buf.rename()<cr>',
    ["<leader>tr"] = ':TroubleToggle<cr>',

    -- diffview
    ["<leader>dv"] = key_utils.toggle_diffview,

    -- use telescopes for registers invocation instead
    ["<leader>p"] = ":Telescope registers<cr>",

    -- buffer movement
    ["[b"] = ":bprev<cr>",
    ["]b"] = ":bnext<cr>",
    ["<PageUp>"] = ":bprev<cr>",
    ["<PageDown>"] = ":bnext<cr>",
    ["[t"] = ":tabp<cr>",
    ["]t"] = ":tabn<cr>",

    -- tmux-like splitting
    ["<c-w>%"] = ":vsplit<cr>",
    ["<c-w>\""] = ":split<cr>",
    ["<c-w>z"] = ":only<cr>",
    -- alternate window movement
    ["[w"] = "<c-w><left>",
    ["]w"] = "<c-w><right>",

    -- Telescope
    -- for local files and local tags
    ["<c-o>"] = ":Telescope find_files<cr>",
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
    ['zR'] = ufo.openAllFolds,
    ['zM'] = ufo.closeAllFolds,

    -- smarter shift I
    ['I'] = key_utils.smarter_shift_i,
  },
  -- Visual mode
  v = {
    -- select whole words by default
    ["w"] = "iw",
    ["W"] = "iW",
    [")"] = "i)",
    ["]"] = "i]",
    ["\""] = "i\"",

    -- replace currently selected text with default register
    -- without yanking it.
    ["p"] = "\"_dP",

    -- same as normal but also does a non-yanking deletion first
    ["<leader>p"] = "\"_d<esc>:Telescope registers<cr>",
  },
  [{'n', 'v'}] = {
    -- faster movement
    ["<c-Up>"] = "10k",
    ["<c-Down>"] = "10j",
    -- meta+f to select and go to one specific letter on screen
    ['<m-f>'] = flash.jump,
    -- better cutting (`x` no longer yanks due to cutlass,
    -- but it doesn't delete the whole line.)
    ["X"] = '"_dd',
    -- jump to first position after the first space (to avoid comment prefixes).
    ['0'] = key_utils.alternating_zero,
  },
  -- Terminal mode
  t = {
    -- terminal mode exit
    ['<esc>'] = "<C-\\><C-n>",
  }
}

for mode, conf in pairs(key_configs) do
  for key, command in pairs(conf) do
    vim.keymap.set(mode, key, command, { noremap = true, silent = true })
  end
end
