" ============================
" Plugins
" ============================

" Setup vim-Plug
set nocompatible
call plug#begin('~/.vim/bundle')

" ============================
" passive plugins
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
let g:signify_sign_change = '~'
if isGoogle
  let g:signify_vcs_list = ['perforce', 'hg', 'git']
  let g:signify_vcs_cmds = {
        \ 'perforce':'DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]',
        \ 'git': 'git diff --no-color --no-ext-diff -U0 -- %f',
        \ 'hg': 'hg diff --color=never --config aliases.diff= --nodates -U0 -- %f'
        \ }
else
  let g:signify_vcs_list = ['git']
endif

" changes in current file since last save
Plug 'chrisbra/changesPlugin'

" highlight active pane only
Plug 'TaDaa/vimade'

" fancy startup
" skip if in Google (due to google3's network FS)
Plug 'mhinz/vim-startify', isGoogle ? { 'on': [] } : {}

" pairs
Plug 'tpope/vim-surround'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" lsp
Plug 'neoclide/coc.nvim'
" see coc_specific.vim and coc_config.json for more tweaks

" For performance concerns, removing ale for now
" since it's somehow not quite doing async fixes.
" Plug 'w0rp/ale', isGoogle? {} : { 'on': [] }
" let g:ale_virtualenv_dir_names = []
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 1
" let g:ale_completion_enabled = 0
" let g:ale_sign_error = '!!'
" let g:ale_sign_warning = '??'
" " gpylint requires a separate ale-linter definition script
" let g:ale_linters = {
" \   'python': ['gpylint'],
" \   'java': [],
" \}
" let g:ale_fixers = {
" \   'go': ['gofmt'],
" \}
" " \   'bzl': ['Buildifier'],
" let g:ale_fix_on_save = 1
" let g:ale_python_gpylint_use_global = 1

" Doc Gen
Plug 'kkoomen/vim-doge'
let g:doge_doc_standard_python = 'google'
let g:doge_comment_interactive = 0
let g:doge_mapping_comment_jump_forward = '<C-RIGHT>'
let g:doge_mapping_comment_jump_backward = '<C-LEFT>'

" languages highlighting
Plug 'sheerun/vim-polyglot'

" markdown
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ["python=python","json=json","vimscript=vim","bash=bash"]

" ctrlp -- for finding local files
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlPMRUFiles'
if executable('fd')
  " this allows us to use nice things like skipping gitignored files, etc
  let g:ctrlp_user_command = 'fd . %s -i -tf -c=never'
endif

" incsearch within the file
Plug 'haya14busa/incsearch.vim'
set hlsearch
let g:incsearch#auto_nohlsearch = 1

" visual indicators
Plug 'luochen1990/rainbow'
if rainbowParens
  let g:rainbow_active = 1
  " actual rainbow color from a color wheel
  let g:rainbow_conf = {
  \ 'guifgs': [
  \   '#F6ED56', '#A6C955', '#4BA690', '#4191C9', '#2258A0', '#654997',
  \   '#994D95', '#D45196', '#DB3A35', '#E5783A', '#EC943F', '#F7C247'
  \  ]
  \}
end
Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor=""
let g:indentLine_setConceal = 0

" colorize hex colors like #15c3f2 and #f3a
Plug 'ap/vim-css-color'

" colorschemes
Plug 'jdkanani/vim-material-theme'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'
let g:gruvbox_box_bold = 1
let g:gruvbox_box_underline = 1

" ==========================
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
  cnoreabbrev Ack Ack!
  cnoreabbrev ag Ack!
  cnoreabbrev aG Ack!
  cnoreabbrev Ag Ack!
  cnoreabbrev AG Ack!
endif

" distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" file tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeFind'}
let g:NERDTreeWinPos = "left"
" icons
Plug 'ryanoasis/vim-devicons'

" sublime-like multicursor
" ctrl-n for select next
Plug 'terryma/vim-multiple-cursors'

" autoctag
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_suppress_report = 1
let g:easytags_by_filetype = 1
let g:easytags_on_cursorhold = 0
let g:easytags_python_enabled = 1
let g:easytags_file = '~/.vim/tags'

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
