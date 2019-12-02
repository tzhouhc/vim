" ===========================
" Settings
" ===========================
set autoindent
set expandtab
set shiftwidth=2
set number relativenumber
set stal=2
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
set ignorecase
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

set tags+="~/.vim/tags"

" ShaDa file -- controlling viminfo behavior
" " ' -> marked files
" f -> global marks?
" < -> saved lines for registers
" : -> number of lines to save from the command line history
" @ -> number of lines to save from the input line history
" / -> number of lines to save from the search history
" r -> removable media, for which no marks will be stored (can be
"   used several times)
" ! -> global variables that start with an uppercase letter and
"   don't contain lowercase letters
" h -> disable 'hlsearch' highlighting when starting
" % -> the buffer list (only restored when starting Vim without file
"   arguments)
" c -> convert the text using 'encoding'
" n -> name used for the ShaDa file (must be the last option)
set shada='20,f1,<500,:100,@40,/20
