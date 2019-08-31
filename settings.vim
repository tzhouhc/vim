" ===========================
" Settings
" ===========================
set expandtab
set shiftwidth=2
set number relativenumber
set showcmd

" wrapping
set whichwrap+=>,l
set whichwrap+=<,h
set whichwrap+=[,]

set wildmenu
set lazyredraw
set showmatch

" searching
set incsearch
set hlsearch

" mouse use
set mouse=a

" encoding
set encoding=UTF-8

" clipboard
set clipboard+=unnamedplus

" folding
set foldenable
set foldlevelstart=4
set foldmethod=syntax

" Fix tmux weird color
set t_ut=
runtime macros/matchit.vim

" switch buffer without saving
set hidden
set cmdheight=2
set shortmess=aFc

" persistent undo
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif
