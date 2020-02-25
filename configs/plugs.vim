" ============================
" Plugins
" ============================

" Setup vim-Plug
set nocompatible
call plug#begin('~/.vim/bundle')

" ============================
" Core Plugins
" ============================
" Core plugins are needed for both lean and complex editing modes
" and are always loaded; this selection is *rather arbitrary*

" pairs
Plug 'tpope/vim-surround'

" auto-close pairs
Plug 'Raimondi/delimitMate'

" languages highlighting
Plug 'sheerun/vim-polyglot'

" visual indicators
Plug 'luochen1990/rainbow'
if rainbowParens
  let g:rainbow_active = 1
  " actual rainbow color from a color wheel
  let g:rainbow_conf   = {
  \ 'guifgs': [
  \   '#F6ED56', '#A6C955', '#4BA690', '#4191C9', '#2258A0', '#654997',
  \   '#994D95', '#D45196', '#DB3A35', '#E5783A', '#EC943F', '#F7C247'
  \  ]
  \}
end

" line hinting for indentation
Plug 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = ""
let g:indentLine_setConceal      = 0

" colorschemes
Plug 'arcticicestudio/nord-vim'

" lsp
Plug 'neoclide/coc.nvim'
" NOTE: see coc_specific.vim and coc_config.json for more tweaks

" vim motion
Plug 'easymotion/vim-easymotion'

" trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" quick-comment
" `gc` for commenting
Plug 'tpope/vim-commentary'

" sublime-like multicursor ctrl-n for select next
Plug 'terryma/vim-multiple-cursors'

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Non-Essentials ======
" (but still important and nice)

if !isLeanVim
  " passive plugins ====
  " airline
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  let g:lightline#bufferline#enable_devicons = 1
  " want to figure out how to customize pathshorten
  let g:lightline#bufferline#filename_modifier = ':t'
  source $HOME/.vim/configs/lightline.vim

  " version control signs
  Plug 'mhinz/vim-signify'
  let g:signify_sign_change = '~'
  let g:signify_skip = {
          \ 'vcs': {'deny': ['rcs', 'svn', 'cvs']}
          \ }
  if isGoogle
    let g:signify_vcs_cmds = {
          \ 'perforce':'env DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]',
          \ 'git': 'git diff --no-color --no-ext-diff -U0 -- %f',
          \ 'hg': 'hg diff --color=never --config aliases.diff= --nodates -U0 -- %f'
          \ }
  endif

  " changes gutter in current file since last save
  Plug 'chrisbra/changesPlugin'

  " highlight active pane only make sure neovim's python bindings are up-to-date
  Plug 'TaDaa/vimade'

  " fancy startup
  " skip if in Google (due to google3's network FS)
  Plug 'mhinz/vim-startify', isGoogle ? { 'on': [] } : {}

  " movement around pairs, highlight
  Plug 'andymass/vim-matchup'
  let g:matchup_matchparen_offscreen = {}

  " variable highlighting
  Plug 'jaxbot/semantic-highlight.vim'

  " markdown
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  let g:vim_markdown_conceal              = 2
  let g:vim_markdown_conceal_code_blocks  = 0
  let g:vim_markdown_auto_insert_bullets  = 1
  let g:vim_markdown_new_list_item_indent = 0
  let g:vim_markdown_fenced_languages     = ["python=python","json=json","vimscript=vim","bash=bash"]

  " fzf -- quick jump to file, tag and such
  Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
  Plug 'junegunn/fzf.vim'
  " preview configs
  source $HOME/.vim/configs/fzf.vim

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

  " Active plugins ====

  " easy align
  " `ga` for alignment
  Plug 'junegunn/vim-easy-align'

  " common file system operations
  Plug 'tpope/vim-eunuch'

  " formatter - for outside of Google space
  " `gl` to format visualized text
  Plug 'google/vim-maktaba', isGoogle ? { 'on': [] } : {}
  Plug 'google/vim-codefmt', isGoogle ? { 'on': [] } : {}

  " Doc Gen
  Plug 'kkoomen/vim-doge', { 'on': 'DogeGenerate' }
  let g:doge_doc_standard_python           = 'google'
  let g:doge_comment_interactive           = 0
  let g:doge_mapping_comment_jump_forward  = '<C-RIGHT>'
  let g:doge_mapping_comment_jump_backward = '<C-LEFT>'

  " do not kill split with buffer
  Plug 'qpkorr/vim-bufkill'

  " peekaboo - see contents of registers
  Plug 'junegunn/vim-peekaboo'
  let g:peekaboo_prefix = '<leader>'

  " autoctag
  Plug 'ludovicchabant/vim-gutentags'
  " maybe gutentags doesn't work well with '~'?
  let g:gutentags_cache_dir                = $HOME . "/.vim/tags"
  if isGoogle
    " google3 -- use nearest BUILD file as package root marker
    " otherwise just use git
    " Metadata for doc folders
    let g:gutentags_project_root           = ['BUILD', 'METADATA', '.git']
  endif
  let g:gutentags_file_list_command        = "gutentagger"
  let g:gutentags_resolve_symlinks         = 1
  let g:gutentags_define_advanced_commands = 1

  " undo-tree
  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  let g:undotree_SetFocusWhenToggle = 1
  let g:undotree_ShortIndicators    = 1

  " go do stuff
  Plug 'tpope/vim-dispatch'

  " switch
  " `gs` to switch content under cursor
  Plug 'andrewradev/switch.vim'

  " arpeggio
  Plug 'kana/vim-arpeggio'

  " custom text objects
  Plug 'kana/vim-textobj-user'
  " 'y' means 'the current syntax highlight group'
  Plug 'kana/vim-textobj-syntax'
endif

call plug#end()"}}}
