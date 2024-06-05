-- Keyboard Mapping Configurations

vim.g.mapleader = "\\"

local safe_require = require("lib.meta").safe_require
local key_utils = safe_require("lib.key_utils")
local ufo = safe_require("ufo")
local flash = safe_require("flash")

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
	-- Normal mode
	n = {
		-- cancel search/flash highlight
		["<esc>"] = "<esc>:noh<CR>",
		-- close all non-main windows
		["<esc><esc>"] = ":only<CR>",
		-- leader actions
		["<leader>ev"] = ":e $MYVIMRC<cr>",
		["<leader>en"] = ":e $HOME/.notes<cr>",
		["<leader>ft"] = ":NvimTreeToggle<CR>",
		["<leader>q"] = ":BD<cr>",
		["<leader>dd"] = ":DevdocsOpenCurrentFloat<cr>",
		["<leader>lg"] = ":Git<cr>",

		-- trouble
		["<leader>tr"] = ":Trouble diagnostics toggle filter.buf=0<cr>",

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
    -- trouble movement
    ["[e"] = key_utils.jump_to_prev_trouble_item,
    ["]e"] = key_utils.jump_to_next_trouble_item,
		-- create empty lines without moving
		["[<space>"] = key_utils.add_blank_line_before,
		["]<space>"] = key_utils.add_blank_line_after,

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
		["zR"] = ufo.openAllFolds,
		["zM"] = ufo.closeAllFolds,

		-- smarter shift I
		["I"] = key_utils.smarter_shift_i,
		["<m-i>"] = key_utils.smart_move_to_start_and_insert,
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

		-- same as normal but also does a non-yanking deletion first
		["<leader>p"] = '"_d<esc>:Telescope registers<cr>',
	},
	[{ "n", "v" }] = {
		-- faster movement
		["<c-Up>"] = "10k",
		["<c-Down>"] = "10j",
		-- meta+f to select and go to one specific letter on screen
		["<m-f>"] = flash.jump,
		-- better cutting (`x` no longer yanks due to cutlass,
		-- but it doesn't delete the whole line.)
		["X"] = '"_dd',
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

		-- enter new line but don't keep commenting if currently in comment block
		["<s-cr>"] = "<esc>o<esc>cc",
	},
	-- Terminal mode
	t = {
		-- terminal mode exit
		["<c-w><esc>"] = "<C-\\><C-n>",
	},
}

for mode, conf in pairs(key_configs) do
	for key, val in pairs(conf) do
		if type(val) == "string" or type(val) == "function" then
			-- default configuration
			vim.keymap.set(mode, key, val, { noremap = true, silent = true })
		else
			local command, opts = unpack(val)
			vim.keymap.set(mode, key, command, opts)
		end
	end
end
