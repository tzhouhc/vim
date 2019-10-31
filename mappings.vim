" ===========================
" keymaps
" ===========================

" vertical movement
noremap <Down> gj
noremap <Up> gk
" horizontal
noremap <silent> <C-Left> ^
noremap <silent> <C-Right> $
" cancel search highlight
nnoremap <silent><esc> <esc>:noh<CR><esc>

" mimicking sublime's selection enclose behavior
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap ` <esc>`>a`<esc>`<i`<esc>

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
nnoremap <silent> <leader>p :set paste!<cr>:set number! relativenumber!<cr>:IndentLinesToggle<cr>:SignifyToggle<cr>

" search for stuff
nnoremap <c-f> /\v
map /  <Plug>(incsearch-forward)\v
map ?  <Plug>(incsearch-backward)\v
map g/ <Plug>(incsearch-stay)\v

" ctrl-p second
nnoremap <c-o> :CtrlPMRUFiles<cr>

" switch buffer/tabs
nnoremap <silent> <leader><Left> :bprev<cr>
nnoremap <silent> <leader><Right> :bnext<cr>
nnoremap <silent> <leader><leader><Left> :tabp<cr>
nnoremap <silent> <leader><leader><Right> :tabn<cr>

" tmux-like splitting
nnoremap <c-w>% :vsplit<cr>
nnoremap <c-w>" :split<cr>

" show current text highlight group
nnoremap <silent> <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
