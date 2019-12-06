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

" next place holder in snippet
let g:coc_snippet_next = ']p'
let g:coc_snippet_prev = '[p'

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
map /  /\v
map ?  ?\v
map g/ g/\v

" ctrl-p for local files and local tags; c-p is mru files.
nnoremap <c-o> :Files<cr>
nnoremap <c-p> :History<cr>
" tags in current file
nnoremap <c-i> :BTags<cr>
" tags in *all* files of this type
nnoremap <c-k> :Tags<cr>
" lines in open buffers since why not?
nnoremap <c-l> :Lines<cr>
" nnoremap <c-m> :Marks<cr>
nnoremap <c-f> :Ag<cr>

" faster movement
nnoremap <c-Up> 10k
nnoremap <c-Down> 10j
nnoremap <c-Left> 10h
nnoremap <c-Right> 10l

" buffer movement
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" switch buffer/tabs
nnoremap <silent> <leader><Left> :bprev<cr>
nnoremap <silent> <leader><Right> :bnext<cr>
nnoremap <silent> <leader><leader><Left> :tabp<cr>
nnoremap <silent> <leader><leader><Right> :tabn<cr>

" tmux-like splitting
nnoremap <c-w>% :vsplit<cr>
nnoremap <c-w>" :split<cr>
nnoremap <c-w>z :only<cr>

" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" show current text highlight group
nnoremap <silent> <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
