" ==== Ting's Vim Setup ====
"

" Setup vim-Plug --- "{{{
set nocompatible
call plug#begin('~/.vim/bundle')

" ==== plugins for looks
" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='quantum'

" devicon
" Plug 'ryanoasis/vim-devicons'

" tabular
" ':Tab /:' for alignment with :
Plug 'godlygeek/tabular'

" gitgutter
" not much to say here; it's on by default
Plug 'airblade/vim-gitgutter'

" quickrun
Plug 'vim-scripts/quickrun.vim'

" visual indicators
" Turn on rainbow paren with leader+r
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'

" colorschemes
" Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
" Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'
Plug 'mbbill/vim-seattle'
" Plug 'raphamorim/lucario'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'jdkanani/vim-material-theme'

" ==== plugins for completion
" tab autocomplete
Plug 'ervandew/supertab'

" auto-add end
Plug 'tpope/vim-endwise'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" more autocomplete
Plug 'Shougo/neocomplete'
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" ==== other helpful plugins

" vim motion
" Plug 'easymotion/vim-easymotion'

" kill buffer sans killing the split
Plug 'qpkorr/vim-bufkill'

" trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" sensible settings
Plug 'tpope/vim-sensible'

" quick-comment
" leader+c+space = toggle comment
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1

" quick-run
Plug 'thinca/vim-quickrun'

" recently used
Plug 'mru.vim'

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

" syntax checker
" neomake
Plug 'neomake/neomake'
let g:neomake_error_sign = {'text': '!', 'texthl': 'Error'}
let g:neomake_warning_sign = {'text': '?', 'texthl': 'Question'}

" compiling
Plug 'tpope/vim-dispatch'

" edit scope surrounding
Plug 'tpope/vim-surround'

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

" session save
Plug 'tpope/vim-obsession'

" search around
Plug 'ctrlpvim/ctrlp.vim'

" L9
Plug 'L9'

" fuzzy search
" Plug 'vim-scripts/FuzzyFinder'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" number lines by dist
Plug 'myusuf3/numbers.vim'

" quickrun
Plug 'quickrun.vim'

" ctag lists
Plug 'majutsushi/tagbar'

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ==== additional content
" ==== additional content
" polyglot
Plug 'sheerun/vim-polyglot'


" python
" Plug 'davidhalter/jedi-vim'
" let g:jedi#auto_initialization = 0

" many language support
Plug 'sheerun/vim-polyglot'

" latex
Plug 'vim-latex/vim-latex'
let g:tex_flavor='latex'

call plug#end()"}}}

" ==== begin other, non-plugin stuff ==== "

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

" functions
" ===================================
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


" custom keymaps "{{{
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
nnoremap <silent> <leader>r :QuickRun<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>f :call ToggleNERDTreeFind()<cr>
nnoremap <silent> <leader>u :GundoToggle<cr>
nnoremap <silent> <leader>p :set paste!<cr>

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
"}}}

set foldenable
set foldlevelstart=4

" Fix tmux weird color
set t_ut=
runtime macros/matchit.vim

autocmd filetype crontab setlocal nobackup nowritebackup

autocmd! BufWritePost,BufEnter * Neomake

set background=dark
