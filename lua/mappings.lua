vim.g.mapleader = "\\"

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- ===========================
-- keymaps
-- ===========================
--
-- Guideing Philosophy --
-- * g for movement or code change
--   * gl for formatting
--   " gs for switch
--   * ga for alignment
--   * gc for commenting
--   * gq for rewrap
--   * gd for go to definition
--   * gr for go to references
--
-- * ctrl for common actions
--   * fzf operations
--   * find
--   * revert changes
-- * leader for plugin actions or file operations
-- * meta for what cmd/ctrl in other common text editors would do...?
--   * e.g. change tabs, select all, etc

-- vertical movement
nmap("<Down>", "gj")
nmap("<Up>", "gk")
-- horizontal
nmap("<silent>", "<C-Left> ^")
nmap("<silent>", "<C-Right> $")
-- cancel search highlight
nmap("<esc>", ":noh<CR>")

-- mimicking sublime's selection enclose behavior
vmap("]", "<esc>`>a]<esc>`<i[<esc>")
vmap(")", "<esc>`>a)<esc>`<i(<esc>")
vmap("}", "<esc>`>a}<esc>`<i{<esc>")
vmap("`", "<esc>`>a`<esc>`<i`<esc>")

-- select whole words by default
vmap("w", "iw")
vmap("W", "iW")
vmap(")", "i)")
vmap("]", "i]")
vmap("}", "i}")

-- ==== leader actions ====
-- quickly modify vimrc file
nmap("<leader>ev", ":e $MYVIMRC<cr>")
nmap("<leader>ev", ":e $MYVIMRC<cr>")
nmap("<leader>ep", ":e ~/.vim/configs/plugs.vim<cr>")
nmap("<leader>ef", ":e ~/.vim/ftplugin/<C-R>=&filetype<CR>.vim<CR>")
nmap("<leader>ez", ":e $HOME/.dotfiles/zshrc<cr>")
nmap("<leader>sv", ":source $MYVIMRC<cr>")
nmap("<leader>ft", ":NvimTreeToggle<CR>")
nmap("<leader>dv", ":DiffviewFileHistory<CR>")

-- -- faster movement
nmap("<c-Up>", "10k")
nmap("<c-Down>", "10j")
nmap("<c-Up>", "10k")
nmap("<c-Down>", "10j")
vmap("<c-Up>", "10k")
vmap("<c-Down>", "10j")
vmap("<c-Up>", "10k")
vmap("<c-Down>", "10j")

-- -- switch buffer/tabs
nmap("[b", ":bprev<cr>")
nmap("]b", ":bnext<cr>")
nmap("<PageUp>", ":bprev<cr>")
nmap("<PageDown>", ":bnext<cr>")
nmap("[t", ":tabp<cr>")
nmap("]t", ":tabn<cr>")

-- tmux-like splitting
nmap("<c-w>%", ":vsplit<cr>")
nmap("<c-w>\"", ":split<cr>")
nmap("<c-w>z", ":only<cr>")

-- replace currently selected text with default register
-- without yanking it
vmap("<leader>p", "\"_dP")

-- meta+f to select and go to one specific letter on screen
nmap('<m-f>', '<Plug>(easymotion-bd-f)')
vmap('<m-f>', '<Plug>(easymotion-bd-f)')

-- Telescope
-- for local files and local tags
nmap("<c-o>", ":Telescope find_files<cr>")
-- lines in current buffer
nmap("<c-f>", ":Telescope current_buffer_fuzzy_find<cr>")
-- lines in all local files
nmap("<c-g>", ":Telescope live_grep<cr>")
-- local symbols based on treesitter
nmap("<c-k>", ":Telescope treesitter<cr>")
-- local symbols based on ctags
nmap("<m-k>", ":Telescope tags<cr>")
-- git changes
nmap("<c-p>", ":Telescope oldfiles<cr>")
-- commander
nmap("<m-space>", ":Telescope commander<cr>")
nmap("<m-p>", ":Telescope registers<cr>")
vmap("<m-p>", "d<esc>:Telescope registers<cr>")

-- terminal mode exit
vim.api.nvim_set_keymap('t', '<esc>', "<C-\\><C-n>", { noremap = true, silent = true })

-- better cutting (`x` no longer yanks due to cutlass, but it doesn't delete the whole line.)
nmap("X", '"_dd')
vmap("X", '"_dd')

-- folding
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- jump to first position after the first space (to avoid comment prefixes).
vim.keymap.set('n', '0', require('functions').alternating_zero, { noremap = true, silent = true })
vim.keymap.set('v', '0', require('functions').alternating_zero, { noremap = true, silent = true })

vim.keymap.set('n', 'I', require('functions').smarter_shift_i, { noremap = true, silent = true })

-- lsp actions
nmap("<leader>fc", ':LspZeroFormat<cr>')
nmap("<leader>rn", '<cmd>lua vim.lsp.buf.rename()<cr>')
nmap("<leader>tr", ':TroubleToggle<cr>')
