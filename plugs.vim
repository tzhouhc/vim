" ============================
" Plugins
" ============================

" Setup vim-Plug
set nocompatible
call plug#begin('~/.vim/bundle')

" passive plugins that I don't need to touch
" ============================

" airline
Plug 'vim-airline/vim-airline'
Plug 'tyrannicaltoucan/vim-quantum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='quantum'

" version control signs
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['perforce', 'git', 'hg']
let g:signify_sign_change = '%'

" highlight active only
Plug 'TaDaa/vimade'

" fancy startup
" skip if in Google (due to google3's network FS)
Plug 'mhinz/vim-startify', isGoogle ? { 'on': [] } : {}

" pairs
Plug 'tpope/vim-surround'

" lsp
Plug 'neoclide/coc.nvim'
" see coc_specific.vim and coc_config.json for more tweaks
Plug 'w0rp/ale', isGoogle? {} : { 'on': [] }
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
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ["python=python","json=json","vimscript=vim","bash=bash"]

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'

" incsearch
Plug 'haya14busa/incsearch.vim'
set hlsearch
let g:incsearch#auto_nohlsearch = 1

" visual indicators
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor=""
let g:indentLine_setConceal = 0

" colorize hex colors
Plug 'ap/vim-css-color'

" colorschemes
Plug 'jdkanani/vim-material-theme'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" L9
Plug 'vim-scripts/L9'

" active plugins
" ==========================

" vim motion
Plug 'easymotion/vim-easymotion'

" trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" quick-comment
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1

" ag
Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif

" file tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeFind'}
let g:NERDTreeWinPos = "right"
" icons
Plug 'ryanoasis/vim-devicons'

" sublime-like multicursor
" ctrl-n for select next
Plug 'terryma/vim-multiple-cursors'

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

" undo-tree
Plug 'mbbill/undotree'

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" custom text objects
Plug 'kana/vim-textobj-user'

call plug#end()"}}}
