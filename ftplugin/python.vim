" auto make
set makeprg=python\ %

" somehow python has built-in one-space already
let NERDSpaceDelims = 0

" four spaces default tabs
setlocal  tabstop=4
setlocal  shiftwidth=4
" let g:indent_guides_guide_size = 4

set foldmethod=indent

let b:ale_linters = ['flake8']
let b:ale_fixers = ['isort', 'autopep8']

let g:ale_fix_on_save = 1
