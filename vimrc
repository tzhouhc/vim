" ========================
" Ting's Vim Setup
" ========================

" ==== Global vars ====
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
let isGoogle = isdirectory('/google')
let isNeovim = has('nvim')

" ==== Global personalizations ====
" These are options that are tied to a couple of things deeper down
" in the individual files. This provides a quick single location for toggling
" them.

" vw => viw, etc
let visualMoveWholeWord = v:true
" run rainbow parenthesis by default
let rainbowParens = v:true

" ==== Loading scripts ====

" plugins and plugin settings
source $HOME/.vim/plugs.vim

" generic settings
source $HOME/.vim/settings.vim

" custom text objects
source $HOME/.vim/text_objects.vim

" settings specific to coc
source $HOME/.vim/coc_setup.vim

" settings specific to neovim
if isNeovim
  source $HOME/.vim/nvim_specific.vim
endif

" settings specfic to google3
if isGoogle
  source $HOME/.vim/google_specific.vim
endif

" functions
source $HOME/.vim/functions.vim

" key mappings
source $HOME/.vim/mappings.vim

" settings related to how vim looks
source $HOME/.vim/visuals.vim
