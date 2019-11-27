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
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
source $HOME/.vim/configs/lightline.vim

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

" changes gutter in current file since last save
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

" movement around pairs, highlight
Plug 'andymass/vim-matchup'

" lsp
Plug 'neoclide/coc.nvim'
" NOTE: see coc_specific.vim and coc_config.json for more tweaks

" formatter - for outside of Google space
Plug 'google/vim-maktaba', isGoogle ? { 'on': [] } : {}
Plug 'google/vim-codefmt', isGoogle ? { 'on': [] } : {}

" Doc Gen
Plug 'kkoomen/vim-doge', { 'on': 'DogeGenerate' }
let g:doge_doc_standard_python           = 'google'
let g:doge_comment_interactive           = 0
let g:doge_mapping_comment_jump_forward  = '<C-RIGHT>'
let g:doge_mapping_comment_jump_backward = '<C-LEFT>'

" better writing
Plug 'reedes/vim-pencil'

" languages highlighting
Plug 'sheerun/vim-polyglot'

" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_conceal             = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages    = ["python=python","json=json","vimscript=vim","bash=bash"]

" fzf -- quick jump to file, tag and such
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
" preview configs
source $HOME/.vim/configs/fzf.vim

" easy align
Plug 'junegunn/vim-easy-align'

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
let g:indentLine_noConcealCursor = ""
let g:indentLine_setConceal      = 0

" colorize hex colors like #15c3f2 and #f3a
Plug 'ap/vim-css-color'

" colorschemes
Plug 'arcticicestudio/nord-vim'
" ==== backups ====
" Plug 'jdkanani/vim-material-theme'
" Plug 'ayu-theme/ayu-vim'
" Plug 'rakr/vim-one'
" Plug 'rakr/vim-two-firewatch'
" Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'
let g:gruvbox_box_bold      = 1
let g:gruvbox_box_underline = 1

" icons
Plug 'ryanoasis/vim-devicons'

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

" common file system operations
Plug 'tpope/vim-eunuch'

" file tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeFind'}
let g:NERDTreeWinPos = "left"

" sublime-like multicursor
" ctrl-n for select next
Plug 'terryma/vim-multiple-cursors'

" autoctag
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir         = "~/.vim/tags"
let g:gutentags_file_list_command = 'find . -type f -d 1'
let g:gutentags_resolve_symlinks  = 1
let g:gutentags_ctags_extra_args  = ['--fields=+n']

" ctag lists
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
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
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" custom text objects
Plug 'kana/vim-textobj-user'

call plug#end()"}}}
