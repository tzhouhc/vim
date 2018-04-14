" ==== Ting's Vim Setup ====
"

language en_US

" Plugins
" ==================================

" Setup vim-Plug
set nocompatible
call plug#begin('~/.vim/bundle')

" passive plugins that I don't need to touch
" ============================
" tmux
Plug 'sjl/vitality.vim'

" tmux
Plug 'sjl/vitality.vim'

" Interface
Plug 'Shougo/denite.nvim'

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

" Fastfold
" This is per neocomplete's request
Plug 'Konfekt/FastFold'

" visual indicators
" Turn on rainbow paren with leader+r
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor=""

" colorschemes
" Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'jdkanani/vim-material-theme'

" fancy start
Plug 'mhinz/vim-startify'

" auto-add end
Plug 'tpope/vim-endwise'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" python folding
Plug 'tmhedberg/SimpylFold'

" json folding
Plug 'elzr/vim-json'

" completion
if has('nvim')
  " deoplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
else
  " neocomplete
  Plug 'Shougo/neocomplete'
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 12
  let g:neocomplete#max_keyword_width = 30
  let g:neocomplete#enable_fuzzy_completion = 1
  let g:neocomplete#enable_smart_case = 1
endif

" jedi python
" if has('nvim')
  " Plug 'zchee/deoplete-jedi'
" else
  " Plug 'davidhalter/jedi-vim'
  " let g:jedi#popup_select_first = 1
  " let g:jedi#show_call_signatures = 2
  " let g:jedi#smart_auto_mappings = 0
" endif

" sensible settings
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif

Plug 'w0rp/ale'
let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_list_vertical = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" wait 3 secs prior to any linting
let g:ale_lint_delay = 3000

" edit scope surrounding
Plug 'tpope/vim-surround'

" easier searching
Plug 'junegunn/vim-slash'

" L9
Plug 'vim-scripts/L9'

" number lines by dist
Plug 'myusuf3/numbers.vim'

" polyglot
Plug 'sheerun/vim-polyglot'

" vim snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'ervandew/snipmate.vim'

" tab autocomplete
Plug 'ervandew/supertab'
" use sane order -- to heck with consistency
let g:SuperTabDefaultCompletionType = "<c-n>"

" active plugins; I have to call them
" ==========================

" distraction-free writing
Plug 'junegunn/goyo.vim'
function! s:goyo_enter()
  set wrap linebreak nolist
endfunction

function! s:goyo_leave()
  set nowrap nolinebreak list
endfunction

" tabular
" ':Tab /:' for alignment with :
Plug 'godlygeek/tabular'

" quickrun
Plug 'vim-scripts/quickrun.vim'

" vim motion
Plug 'easymotion/vim-easymotion'

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

" selective replace
Plug 'brooth/far.vim'

" undo
" leader+u
Plug 'sjl/gundo.vim'

" file tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeFind'}
let g:NERDTreeWinPos = "right"

Plug 'Xuyuanp/nerdtree-git-plugin'
let NERDTreeQuitOnOpen=1

" more git stuff
Plug 'tpope/vim-fugitive'

" sublime-like multicursor
" ctrl-n for select next
Plug 'kristijanhusak/vim-multiple-cursors'
function! Multiple_cursors_before()
    echo 'Disabled autocomplete'
endfunction

if !has('nvim')
  function! Multiple_cursors_before()
      exe 'NeoCompleteLock'
      echo 'Disabled autocomplete'
  endfunction

  function! Multiple_cursors_after()
      exe 'NeoCompleteUnlock'
      echo 'Enabled autocomplete'
  endfunction
endif

" search around
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '^build$',
  \ }
let g:ctrlp_extensions = ['line']

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
if !has('nvim')
    set clipboard=exclude:.*
endif

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
nnoremap <silent> <leader>u :GundoToggle<CR>
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

" Fix tmux weird color
set t_ut=
runtime macros/matchit.vim

autocmd filetype crontab setlocal nobackup nowritebackup
autocmd filetype python setlocal completeopt-=preview

set foldlevelstart=99
set colorcolumn=80
set background=dark

" Neovim stuff!
if has('nvim')
  set inccommand=split
endif

" persistent undo
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" tmux + iterm cursor
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
