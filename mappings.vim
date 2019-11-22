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

" formatting using codefmt;
" disabled due to introducing unwanted changes in external code bases
" nnoremap <silent> <leader>l :FormatCode<cr>
nnoremap <silent> <leader>f :call ToggleNERDTreeFind()<cr>
nnoremap <silent> <leader>p :set paste!<cr>:set number! relativenumber!<cr>:IndentLinesToggle<cr>:SignifyToggle<cr>:TCV<cr>

" line formatting
vnoremap <silent> <leader>l :FormatLines<cr>

" search for stuff
nnoremap <c-f> /\v
map /  <Plug>(incsearch-forward)\v
map ?  <Plug>(incsearch-backward)\v
map g/ <Plug>(incsearch-stay)\v

" ctrl-p for local files and local tags; c-p is mru files.
nnoremap <c-o> :CtrlP<cr>
" tags in current file
nnoremap <c-i> :CtrlPBufTag<cr>
" tags in *all* files of this type
nnoremap <c-y> :CtrlPTag<cr>
" recent changes
nnoremap <c-c> :CtrlPChange<cr>
" lines in current file... sort of just like a search, but fuzzier
nnoremap <c-l> :CtrlPLine<cr>

" switch buffer/tabs
nnoremap <silent> <leader><Left> :bprev<cr>
nnoremap <silent> <leader><Right> :bnext<cr>
nnoremap <silent> <leader><leader><Left> :tabp<cr>
nnoremap <silent> <leader><leader><Right> :tabn<cr>

" tmux-like splitting
nnoremap <c-w>% :vsplit<cr>
nnoremap <c-w>" :split<cr>
nnoremap <c-w>z :only<cr>

" show current text highlight group
nnoremap <silent> <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
