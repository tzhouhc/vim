" auto make
set makeprg=python\ %

" somehow python has built-in one-space already
let NERDSpaceDelims = 0

" four spaces default tabs
if isGoogle
  setlocal  tabstop=2
  setlocal  shiftwidth=2
  let g:indent_guides_guide_size = 2
else
  setlocal  tabstop=4
  setlocal  shiftwidth=4
  let g:indent_guides_guide_size = 4
endif

set foldmethod=indent
set formatoptions+=a
