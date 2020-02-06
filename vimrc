" ========================
" Ting's Vim Setup
" ========================

" ==== Global vars ====
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
let isGoogle = isdirectory('/google')
let isNeovim = has('nvim')

" Lean Vim removes many of the plugins, for cases where launch speed is
" absolutely crucial
let isLeanVim = $LEANVIM == 'true'

" ==== Global personalizations ====
" These are options that are tied to a couple of things deeper down
" in the individual files. This provides a quick single location for toggling
" them.

" vw => viw, etc
let visualMoveWholeWord = v:true
" run rainbow parenthesis by default
let rainbowParens = v:true
" toggle italics
let useItalics = v:true
" use staging variant of ciderlsp
let useCiderStaging = v:true
" highlight line with cursor
let useCursorLine = v:true
" highlight word under cursor
let highlightCursor = v:false
" status line shows current cursor highlight group
let highlightGroupHint = v:false

" ==== Loading scripts ====
" Why not use plugin/? loading sequence.
" Having explicit `source` statements also make it easier to selectively disable
" portions of the vimrc

" plugins and plugin settings
source $HOME/.vim/configs/plugs.vim

" generic settings
source $HOME/.vim/configs/settings.vim

" custom text objects
if !isLeanVim
  source $HOME/.vim/configs/text_objects.vim
endif

" settings specific to coc
source $HOME/.vim/configs/coc_setup.vim

" settings specific to neovim
if isNeovim
  source $HOME/.vim/configs/nvim_specific.vim
endif

" settings specfic to google3
if isGoogle && !isLeanVim
  source $HOME/.vim/configs/google_specific.vim
endif

" functions
source $HOME/.vim/configs/functions.vim

" auto-commands
source $HOME/.vim/configs/auto.vim

" key mappings
source $HOME/.vim/configs/mappings.vim

" settings related to how vim looks
source $HOME/.vim/configs/visuals.vim

set runtimepath+=~/.vim/local/after
