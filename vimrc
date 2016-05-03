"
" ==== Ting's Vim Setup ====
"

" Setup Vundle
set nocompatible
call plug#begin('~/.vim/bundle')

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

" ==== plugins for looks
" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" gitgutter
Plug 'airblade/vim-gitgutter'

" visual indicators
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

" ==== plugins for completion
" tab autocomplete
Plug 'ervandew/supertab'

" auto-add endd
Plug 'tpope/vim-endwise'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" more autocomplete
Plug 'Shougo/neocomplete'

" ==== other helpful plugins

" trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" sensible settings
Plug 'tpope/vim-sensible'

" quick-comment
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1

" ack
Plug 'mileszs/ack.vim'
" use ag instead
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" undo
Plug 'sjl/gundo.vim'

" file tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}

" syntax checker
Plug 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3
let g:syntastic_python_checkers = ['pep8', 'pep257']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": ["ruby"] }

" compiling
Plug 'tpope/vim-dispatch'

" edit scope surrounding
Plug 'tpope/vim-surround'

" more git stuff
Plug 'tpope/vim-fugitive'

" sublime-like multicursor
Plug 'terryma/vim-multiple-cursors'

" search around
Plug 'ctrlpvim/ctrlp.vim'

" number lines by dist
Plug 'myusuf3/numbers.vim'

" ctag lists
Plug 'majutsushi/tagbar'

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ==== additional content
" fish
Plug 'dag/vim-fish'

" latex
Plug 'vim-latex/vim-latex'
let g:tex_flavor='latex'

call plug#end()

" ==== begin other, non-plugin stuff ==== "

" vim 24-bit color mode
if !has("gui_running")
  if has('termtruecolor')
    set guicolors
  endif
endif

" vim cursor
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" alternate viminfo location
set viminfo+=n~/.vim/viminfo

set shell=bash
syntax on
set foldmethod=syntax

set mouse=a

set background=dark
colorscheme colorsbox-material "base16-default

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set noshowmode

set tabstop=2
set softtabstop=2
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

" custom keymaps
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
vnoremap < <esc>`>a><esc>`<i<
vnoremap $ <esc>`>a$<esc>`<i$

" common utilities
nnoremap <silent> <leader>g :GitGutterToggle<cr>
nnoremap <silent> <leader>r :RainbowParenthesesToggle<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>f :NERDTreeToggle<cr>
nnoremap <silent> <leader>u :GundoToggle<cr>

nnoremap <silent> <Space> :noh<cr>

nnoremap <silent> <leader>ev :tabe $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

set foldenable
set foldlevelstart=4

runtime macros/matchit.vim


