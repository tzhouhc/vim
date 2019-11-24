" ===========================
" Settings
" ===========================
set autoindent
set expandtab
set shiftwidth=2
set number relativenumber
set showcmd

" wrapping
set whichwrap+=>,l
set whichwrap+=<,h
set whichwrap+=[,]

" tab completion for commands
set wildmenu
set wildmode=longest:full,full
" saves time by not frequently redrawing stuff
set lazyredraw
set showmatch
" pwd is always current file -- helpful for ctrl-o
set autochdir

" searching
set incsearch
" check case when query has uppercase letters
set smartcase
set hlsearch

" mouse use
set mouse=a

" encoding
set encoding=UTF-8

" clipboard
set clipboard+=unnamedplus

if useCursorLine
  set cursorline
endif

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
