" ==== Ting's Vim Setup ====

" Google
source /usr/share/vim/google/google.vim
" Glug youcompleteme-google
Glug critique plugin[mappings]

Glug codefmt gofmt_executable="goimports"
Glug codefmt-google

" blaze
Glug blaze plugin[mappings] !alerts
Glug blazedeps auto_filetypes=`['go']`

" Plugins
" ==================================

" Setup vim-Plug
set nocompatible
call plug#begin('~/.vim/bundle')

" passive plugins that I don't need to touch
" ============================

" Interface
" auto
Plug 'Shougo/denite.nvim'

" airline
" auto
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tyrannicaltoucan/vim-quantum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='quantum'

" p4 signs
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['perforce', 'git']
let g:signify_sign_change = '%'

" highlight active only
Plug 'TaDaa/vimade'

" pairs
Plug 'tpope/vim-surround'

" lsp

Plug 'neoclide/coc.nvim'
Plug 'w0rp/ale'
let g:ale_virtualenv_dir_names = []
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '??'
let g:ale_linters = {
\   'python': ['gpylint'],
\}
let g:ale_fixers = {
\   'go': ['gofmt']
\}
let g:ale_fix_on_save = 1

" ruby
" if executable('solargraph')
    " " gem install solargraph
    " au User lsp_setup call lsp#register_server({
        " \ 'name': 'solargraph',
        " \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        " \ 'initialization_options': {"diagnostics": "true"},
        " \ 'whitelist': ['ruby'],
        " \ })
  " endif

" go
" if executable('gopls')
  " au User lsp_setup call lsp#register_server({
      " \ 'name': 'gopls',
      " \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
      " \ 'whitelist': ['go'],
      " \ })
  " autocmd BufWrite *.go LspDocumentFormatSync
" endif

" kythe
" au User lsp_setup call lsp#register_server({
    " \ 'name': 'Kythe Language Server',
    " \ 'cmd': {server_info->['/google/bin/releases/grok/tools/kythe_languageserver', '--google3']},
    " \ 'whitelist': ['python', 'java', 'cpp', 'proto', 'go'],
    " \})

" ciderlsp - c, go, etc
" au User lsp_setup call lsp#register_server({
    " \ 'name': 'CiderLSP',
    " \ 'cmd': {server_info->[
    " \   '/google/bin/releases/editor-devtools/ciderlsp',
    " \   '--tooltag=vim-lsp',
    " \   '--noforward_sync_responses',
    " \ ]},
    " \ 'whitelist': ['c', 'cpp', 'proto', 'textproto', 'go'],
    " \ })

" python linting and completion is handled by gpylint and YCM respectively
" since ciderlsp python-support is still in progress (go/ciderlsp)

" Doc Gen
Plug 'kkoomen/vim-doge'
let g:doge_doc_standard_python = 'google'
let g:doge_comment_interactive = 0
let g:doge_mapping_comment_jump_forward = '<C-RIGHT>'
let g:doge_mapping_comment_jump_backward = '<C-LEFT>'

" languages
Plug 'sheerun/vim-polyglot'

" markdown
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ["python=python","json=json","vimscript=vim","bash=bash"]

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'

" visual indicators
" Turn on rainbow paren with leader+r
Plug 'kien/rainbow_parentheses.vim'
" Maybe auto change indentline color?
Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor=""

" colorschemes
" Plug 'flazz/vim-colorschemes'
Plug 'jdkanani/vim-material-theme'

" fancy start
" auto
Plug 'mhinz/vim-startify'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" L9
Plug 'vim-scripts/L9'

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
Plug 'brookhong/ag.vim'

" file tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeFind'}
let g:NERDTreeWinPos = "right"

" sublime-like multicursor
" ctrl-n for select next
Plug 'terryma/vim-multiple-cursors'
function! Multiple_cursors_before()
    echo 'Disabled autocomplete'
endfunction

" ctag lists
Plug 'majutsushi/tagbar'
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
          \ 'p:package',
          \ 'i:imports:1',
          \ 'c:constants',
          \ 'v:variables',
          \ 't:types',
          \ 'n:interfaces',
          \ 'w:fields',
          \ 'e:embedded',
          \ 'm:methods',
          \ 'r:constructor',
          \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
          \ 't' : 'ctype',
          \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
          \ 'ctype' : 't',
          \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \}
	

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
set encoding=utf8

" clipboard
if !has('nvim')
    set clipboard=exclude:.*
else
    set clipboard+=unnamedplus
endif

set foldenable
set foldlevelstart=4
set foldmethod=syntax

runtime macros/matchit.vim

" let &runtimepath.=',~/.vim/bundle/ale'

" Fix tmux weird color
set t_ut=
runtime macros/matchit.vim


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

" quickly modify vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" common utilities
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>f :call ToggleNERDTreeFind()<cr>
nnoremap <silent> <leader>p :set paste!<cr>:set number! relativenumber!<cr>:IndentLinesToggle<cr>

nnoremap <silent><esc> <esc>:noh<CR><esc>
nnoremap <silent> <leader>nn :NumbersToggle<cr>
nnoremap <silent> <leader>fj :%!python -m json.tool<cr>

" tab switch buffer
nnoremap <silent> <leader><Left> :bprev<cr>
nnoremap <silent> <leader><Right> :bnext<cr>

" other options
set conceallevel=2
set concealcursor-=n
set foldlevelstart=99
set colorcolumn=80
set background=dark
" switch buffer without saving
set hidden
set cmdheight=2
set shortmess=aFc
" italics
set t_ZH=[3m
set t_ZR=[23m

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

" rainbow parens
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" =================
" Coc-nvim
" =================

function! CocActionAsync(...) abort
  return s:AsyncRequest('CocAction', a:000)
endfunction

function! CocRequestAsync(...)
  return s:AsyncRequest('sendRequest', a:000)
endfunction

function! s:AsyncRequest(name, args) abort
  let Cb = a:args[len(a:args) - 1]
  if type(Cb) == 2
    if !coc#rpc#ready()
      call Cb('service not started', v:null)
    else
      call coc#rpc#request_async(a:name, a:args[0:-2], Cb)
    endif
    return ''
  endif
  call coc#rpc#notify(a:name, a:args)
  return ''
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" goto places
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>

augroup EditVim
  autocmd!
  autocmd filetype crontab setlocal nobackup nowritebackup
  "autocmd filetype python setlocal completeopt-=preview
  autocmd CursorHold * silent call CocActionAsync('doHover')
augroup END

augroup AutoFormat
  autocmd FileType go AutoFormatBuffer gofmt
augroup END

" =================
" custom highlights
" =================

highlight Special gui=italic
"highlight Comment gui=italic
highlight SignifySignAdd guifg=#2dd671
highlight SignifySignDelete guifg=#d94a0d
highlight SignifySignChange guifg=#e6bf12
