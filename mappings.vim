" ===========================
" keymaps
" ===========================
noremap <Down> gj
noremap <Up> gk
noremap <silent> <C-Left> ^
noremap <silent> <C-Right> $

" mimicking sublime's selection enclose behavior
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap ` <esc>`>a`<esc>`<i`<esc>
" vnoremap < <esc>`>a><esc>`<i<

" select whole words by default
if visualMoveWholeWord
  vnoremap w iw
  vnoremap W iW
  vnoremap ) i)
  vnoremap ] i]
  vnoremap } i}
endif

" quickly modify vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" common utilities
nnoremap <silent> <leader>u :UndotreeToggle<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>f :call ToggleNERDTreeFind()<cr>
nnoremap <silent> <leader>p :set paste!<cr>:set number! relativenumber!<cr>:IndentLinesToggle<cr>
nnoremap <silent> <leader>ch :ColorToggle<cr>

nnoremap <silent><esc> <esc>:noh<CR><esc>
nnoremap <silent> <leader>nn :NumbersToggle<cr>
nnoremap <silent> <leader>fj :%!python -m json.tool<cr>

map /  <Plug>(incsearch-forward)\v
map ?  <Plug>(incsearch-backward)\v
map g/ <Plug>(incsearch-stay)\v

nnoremap <c-f> /\v

" switch buffer/tabs
nnoremap <silent> <leader><Left> :bprev<cr>
nnoremap <silent> <leader><Right> :bnext<cr>
nnoremap <silent> <leader><leader><Left> :tabp<cr>
nnoremap <silent> <leader><leader><Right> :tabn<cr>

" tmux-like splitting
nnoremap <c-w>% :vsplit<cr>
nnoremap <c-w>" :split<cr>
