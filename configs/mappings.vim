" ===========================
" keymaps
" ===========================
"
" Guideing Philosophy --
" * g for movement or code change
"   * gl for formatting
"   " gs for switch
"   * ga for alignment
"   * gc for commenting
"   * gq for rewrap
"   * gd for go to definition
"   * gr for go to references
"
" * ctrl for common actions
"   * fzf operations
"   * find
"   * revert changes
" * leader for plugin actions or file operations
" * meta for what cmd/ctrl in other common text editors would do...?
"   * e.g. change tabs, select all, etc

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
vnoremap ] <esc>`>a]<esc>`<i[<esc>
vnoremap ) <esc>`>a)<esc>`<i(<esc>
vnoremap } <esc>`>a}<esc>`<i{<esc>
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

" ==== leader actions ====
" quickly modify vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>ep :e ~/.vim/configs/plugs.vim<cr>
nnoremap <silent> <leader>ef :e ~/.vim/ftplugin/<C-R>=&filetype<CR>.vim<CR>
nnoremap <silent> <leader>ez :e $HOME/.dotfiles/zshrc<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>
nnoremap <silent> <leader>fa :call ToggleFlag("formatoptions","a")<CR>

nnoremap <silent> <leader><leader>c :CsThis<cr>

" search for stuff
map /  /\v
map ?  ?\v
map g/ g/\v
" search visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" faster movement
nnoremap <c-Up> 10k
nnoremap <c-Down> 10j
vnoremap <c-Up> 10k
vnoremap <c-Down> 10j

" switch buffer/tabs
nnoremap <silent> [b :bprev<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [t :tabp<cr>
nnoremap <silent> ]t :tabn<cr>

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
" deprecated in favor of lightline section
nnoremap <silent> <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" With the ESC+ option from iterm, neovim allows one to use meta+ key maps.
if isNeovim
  inoremap <M-d> <esc>viw
  inoremap <M-a> <esc><S-v>
  inoremap <M-A> <esc>gg<S-v>G
  nnoremap <M-d> <esc>viw
  nnoremap <M-a> <esc><S-v>
  nnoremap <M-A> <esc>gg<S-v>G
  nnoremap <M-n> :tabe<cr>

  " meta+f to select and go to one specific letter on screen
  map  <M-f> <Plug>(easymotion-bd-f)
  nmap <M-f> <Plug>(easymotion-overwin-f)
  map  <M-F> <Plug>(easymotion-bd-f2)
  nmap <M-F> <Plug>(easymotion-overwin-f2)
endif

" If in lean mode, many kep mappings wouldn't work
if !isLeanVim
  " line formatting
  vnoremap <silent> gl :FormatLines<cr>

  " common utilities
  nnoremap <silent> <leader>u :UndotreeToggle<cr>
  nnoremap <silent> <leader>t :TagbarToggle<cr>

  " semantic highlighting
  nnoremap <silent> <leader>sh :SemanticHighlightToggle<cr>

  " ==== lightline tab jump ====
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

  " ==== FZF ====
  " ctrl-p for local files and local tags
  nnoremap <c-o> :Files<cr>
  " mru files
  nnoremap <c-p> :History<cr>
  " tags in current file; note that ^i is equivalent to <tab> due to terminal
  " stupidity
  nnoremap <c-i> :BTags<cr>
  " tags in *all* files of this type
  nnoremap <c-k> :Tags<cr>
  " lines in current buffer
  nnoremap <c-f> :BLines<cr>
  " local folder content search
  nnoremap <c-g> :Ag<cr>
  " marks disabled due to unactionable content
  " nnoremap <c-m> :Marks<cr>
  if isGoogle
    nnoremap <c-j> :G4Files<cr>
  endif

  " ==== Arpeggios ====
  call arpeggio#load()

  " empty line without movement
  Arpeggio nnoremap io o<esc>k
  Arpeggio nnoremap IO O<esc>j

  Arpeggio nnoremap cw ciw
  Arpeggio nnoremap cW ciW
  Arpeggio nnoremap c) ci)
  Arpeggio nnoremap c] ci]
  Arpeggio nnoremap c} ci}
  Arpeggio nnoremap vw viw
  Arpeggio nnoremap vW viW
  Arpeggio nnoremap v) vi)
  Arpeggio nnoremap v] vi]
  Arpeggio nnoremap v} vi}
endif
