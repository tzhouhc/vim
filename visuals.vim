" ===========================
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
else " nvim counts as gui-vim
  colorscheme material-theme
endif

" italics
set t_ZH=[3m
set t_ZR=[23m

" rainbow parens
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" other options
set conceallevel=2
set concealcursor-=n
set foldlevelstart=99
set colorcolumn=80
set background=dark
