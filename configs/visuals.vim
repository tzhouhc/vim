" ===========================
" Visual
" ===========================

" determine if we have true color available.
" of course, this ultimately depends on the terminal; modern vim almost always
" has true color available one-way or another
let hasTrueColor = v:false
if has('gui_running') || has('nvim') || has("termguicolors")
  if has('termguicolors')
    set termguicolors
  endif
  let hasTrueColor = v:true
endif

if hasTrueColor
  colorscheme nord
else
  colorscheme gruvbox
endif

" italics setup
set t_ZH=[3m
set t_ZR=[23m

" other options
set conceallevel=2
set concealcursor="nc"
set foldlevelstart=99
set colorcolumn=80

" =================
" custom highlights
" =================
" highlights run last since we don't want the color-scheme overwriting them

if useItalics
  let g:gruvbox_box_italic = 1
  highlight Special gui=italic
  highlight Comment gui=italic
  highlight Italic gui=italic
  highlight Bold gui=bold
  highlight mkdBold gui=bold
  highlight htmlItalic gui=italic
endif

if &background ==# 'dark'
  highlight SignifySignAdd guifg=#2dd671
  highlight SignifySignDelete guifg=#d94a0d
  highlight SignifySignChange guifg=#e6bf12

  highlight QuickScopePrimary guifg=#71eb34 gui=underline
  highlight QuickScopeSecondary guifg=#348feb gui=bold
else
  " light mode has the colors toned down quite a bit
  " though really, why would I use a light theme???
  highlight SignifySignAdd guifg=#1d6631
  highlight SignifySignDelete guifg=#792a0d
  highlight SignifySignChange guifg=#b69f12

  highlight QuickScopePrimary guifg=#518b14 gui=underline
  highlight QuickScopeSecondary guifg=#145fcb gui=bold
endif
