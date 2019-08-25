" ==== Ting's Vim Setup ====
"

" Plugins
" ==================================

" Setup vim-Plug
set nocompatible
call plug#begin('~/.vim/bundle')

" passive plugins that I don't need to touch
" ============================
" tmux
" auto
Plug 'sjl/vitality.vim'

" Interface
" auto
Plug 'Shougo/denite.nvim'

" airline
" auto
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='quantum'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" gitgutter
" auto
Plug 'airblade/vim-gitgutter'

" highlight active only
Plug 'TaDaa/vimade'

" Fastfold
" This is per neocomplete's request
Plug 'Konfekt/FastFold'

" visual indicators
" Turn on rainbow paren with leader+r
Plug 'kien/rainbow_parentheses.vim'
" Maybe auto change indentline color?
Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor=""

" colorschemes
" Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'jdkanani/vim-material-theme'

" fancy start
" auto
Plug 'mhinz/vim-startify'

" auto-add end
Plug 'tpope/vim-endwise'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" json folding
Plug 'elzr/vim-json'

" completion
" if has('nvim')
  " " deoplete
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " let g:deoplete#enable_at_startup = 1
" else
  " " neocomplete
  " Plug 'Shougo/neocomplete'
  " let g:neocomplete#enable_at_startup = 1
  " let g:neocomplete#max_list = 12
  " let g:neocomplete#max_keyword_width = 30
  " let g:neocomplete#enable_fuzzy_completion = 1
  " let g:neocomplete#enable_smart_case = 1
" endif
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'neoclide/jsonc.vim'

" docker
Plug 'ekalinin/Dockerfile.vim'

" julia
Plug 'JuliaEditorSupport/julia-vim'

" sensible settings
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif

" common snippets
Plug 'honza/vim-snippets'

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

" tab autocomplete
"Plug 'ervandew/supertab'
" use sane order -- to heck with consistency
"let g:SuperTabDefaultCompletionType = "<c-n>"

" active plugins; I have to call them
" ==========================

" vim motion
" learned;
Plug 'easymotion/vim-easymotion'

" trailing whitespace
" auto;
Plug 'bronson/vim-trailing-whitespace'

" quick-comment
" familiar
" leader+c+space = toggle comment
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1

" ag
" learned
Plug 'brookhong/ag.vim'

" selective replace
Plug 'brooth/far.vim'

" undo
" leader+u
" not frequently used; consider eventual removal
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
Plug 'terryma/vim-multiple-cursors'
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

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

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
" nnoremap <silent> <leader>r :QuickRun<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>f :call ToggleNERDTreeFind()<cr>
nnoremap <silent> <leader>u :GundoToggle<CR>

" To copy to system clipboard, just do "+y

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

" =====
" Coc suggested features for better completion
" =====
"
" Items to install:
" coc-python
" coc-snippets
" coc-json

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" signature help
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

set foldlevelstart=99
set colorcolumn=80
set background=dark
" switch buffer without saving
set hidden

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

" Custom highlights
highlight Comment gui=italic
