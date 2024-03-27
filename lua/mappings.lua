local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
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
nmap("<silent><esc>", "<esc>:noh<CR><esc>")

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
nmap("<leader>fc", ":FormatCode<CR>")

-- -- faster movement
nmap("<c-Up>", "10k")
nmap("<c-Down>", "10j")
nmap("<c-Up>", "10k")
nmap("<c-Down>", "10j")

-- -- switch buffer/tabs
nmap("[b", ":bprev<cr>")
nmap("]b", ":bnext<cr>")
nmap("<PageUp>", ":bprev<cr>")
nmap("<PageDown>", ":bnext<cr>")
nmap("[t", ":tabp<cr>")
nmap("]t", ":tabn<cr>")

-- -- tmux-like splitting
nmap("<c-w>%", ":vsplit<cr>")
nmap("<c-w>\"", ":split<cr>")
nmap("<c-w>z", ":only<cr>")

-- -- no-yanking ops
-- -- delete without yanking
nmap("<leader>d", "\"_d")
vmap("<leader>d", "\"_d")

-- -- replace currently selected text with default register
-- -- without yanking it
vmap("<leader>p", "\"_dP")

--   " meta+f to select and go to one specific letter on screen
--   map  <c-f> <Plug>(easymotion-bd-f)
--   nmap <c-f> <Plug>(easymotion-overwin-f)
-- endif

-- " ==== FZF ====
-- " ctrl-p for local files and local tags
-- nnoremap <c-o> :Files<cr>
-- " mru files
-- nnoremap <c-p> :G4Files<cr>
-- " tags in current file; note that ^i is equivalent to <tab> due to terminal
-- " stupidity
-- nnoremap <c-l> :Tags<cr>
-- " tags in *all* files of this type
-- nnoremap <c-k> :BTags<cr>
-- " lines in current buffer
-- nnoremap <M-f> :BLines<cr>
-- " local folder content search
-- nnoremap <M-F> :Ag<cr>
-- " marks disabled due to unactionable content
-- " nnoremap <c-m> :Marks<cr>
