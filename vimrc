" ==== Ting's Vim Setup ====
"

" Plugins
" ==================================

" Setup vim-Plug
set nocompatible
call plug#begin('~/.vim/bundle')

" passive plugins that I don't need to touch
" ============================

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='quantum'

" gitgutter
" not much to say here; it's on by default
Plug 'airblade/vim-gitgutter'

" visual indicators
" Turn on rainbow paren with leader+r
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor=""

" colorschemes
" Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
" Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'
Plug 'mbbill/vim-seattle'
" Plug 'raphamorim/lucario'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'jdkanani/vim-material-theme'

" tab autocomplete
Plug 'ervandew/supertab'

" auto-add end
Plug 'tpope/vim-endwise'

" auto-close pairs
Plug 'Raimondi/delimitMate'

Plug 'Shougo/neocomplete'
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" sensible settings
Plug 'tpope/vim-sensible'

" syntax checker
Plug 'neomake/neomake'
let g:neomake_error_sign = {'text': '!', 'texthl': 'Error'}
let g:neomake_warning_sign = {'text': '?', 'texthl': 'Question'}
" linter settings
let g:neomake_python_enabled_makers = ['flake8', 'mypy']

" edit scope surrounding
Plug 'tpope/vim-surround'

" L9
Plug 'L9'

" number lines by dist
Plug 'myusuf3/numbers.vim'

" polyglot
Plug 'sheerun/vim-polyglot'


" active plugins; I have to call them
" ==========================

" tabular
" ':Tab /:' for alignment with :
Plug 'godlygeek/tabular'

" quickrun
Plug 'vim-scripts/quickrun.vim'

" vim motion
Plug 'easymotion/vim-easymotion'

" kill buffer sans killing the split
Plug 'qpkorr/vim-bufkill'

" trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" quick-comment
" leader+c+space = toggle comment
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1

" ack
Plug 'mileszs/ack.vim'
" use ag instead
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" undo
" leader+u
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}

" file tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeFind'}
Plug 'Xuyuanp/nerdtree-git-plugin'
let NERDTreeQuitOnOpen=1

" compiling
Plug 'tpope/vim-dispatch'

" more git stuff
Plug 'tpope/vim-fugitive'

" fancy live-running code
Plug 'metakirby5/codi.vim'

" sublime-like multicursor
" ctrl-n for select next
Plug 'terryma/vim-multiple-cursors'

" split/join
" gs/gJ for splitting/joining
Plug 'AndrewRadev/splitjoin.vim'

" search around
Plug 'ctrlpvim/ctrlp.vim'

" fuzzy search
" Plug 'vim-scripts/FuzzyFinder'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" ctag lists
Plug 'majutsushi/tagbar'

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

call plug#end()"}}}

" ==== end plugins ==== "

" ==== begin other, non-plugin stuff ==== "

" Visual
" ===========================
set background=dark

" vim 24-bit color mode
if !has("gui_running") " if terminal vim
 if has('termguicolors') " if has true color and is local
   set termguicolors
   colorscheme material-theme
 else
   colorscheme gruvbox
 endif
else
  colorscheme material-theme
endif

" Settings
" ===========================
set expandtab
set shiftwidth=2
set number
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
set encoding=utf8

" clipboard
set clipboard=exclude:.*

set foldenable
set foldlevelstart=4
set foldmethod=syntax
let g:vim_markdown_conceal = 0

" Fix tmux weird color
set t_ut=
runtime macros/matchit.vim

let &runtimepath.=',~/.vim/bundle/ale'
autocmd filetype crontab setlocal nobackup nowritebackup

" functions
" ============================
function! ToggleNERDTreeFind()
  if exists('g:NERDTree.IsOpen') 
    if g:NERDTree.IsOpen()
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
  else
    execute ':NERDTreeFind'
  endif
endfunction

" keymaps
" ===========================
noremap <Down> gj
noremap <Up> gk
noremap <silent> <C-Left> ^
noremap <silent> <C-Right> $

" undo, redo
inoremap <c-z> <esc>ui
inoremap <c-u> <esc><c-r>i

" mimicking sublime's selection enclose behavior
vnoremap " <esc>`>a"<esc>`<i"
vnoremap ' <esc>`>a'<esc>`<i'
vnoremap [ <esc>`>a]<esc>`<i[
vnoremap ( <esc>`>a)<esc>`<i(
vnoremap { <esc>`>a}<esc>`<i{
" vnoremap < <esc>`>a><esc>`<i<
" vnoremap $ <esc>`>a$<esc>`<i$

" tab switch buffer
nnoremap <leader><Right> :bnext<CR>
nnoremap <leader><Left> :bprevious<CR>

" common utilities
nnoremap <silent> <leader>g :GitGutterToggle<cr>
" nnoremap <silent> <leader>r :RainbowParenthesesToggle<cr>
" nnoremap <silent> <leader>r :QuickRun<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>f :call ToggleNERDTreeFind()<cr>
nnoremap <silent> <leader>u :GundoToggle<cr>
nnoremap <silent> <leader>p :set paste!<cr>:set number!<cr>:NumbersToggle<cr>:IndentLinesToggle<cr>::GitGutterToggle<cr>

nnoremap <silent> <Space> :noh<cr>
nnoremap <silent> <leader>nn :NumbersToggle<cr>
nnoremap <silent> <leader>fj :%!python -m json.tool<cr>

nnoremap <silent> <leader><Left> :bprev<cr>
nnoremap <silent> <leader><Right> :bnext<cr>

" quickly modify vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" Other convenience methods
nnoremap <silent> <leader>nn :NumbersToggle<CR>

" Autorun syntax check
autocmd! BufWritePost * Neomake
