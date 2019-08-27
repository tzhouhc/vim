setlocal  noexpandtab
setlocal  tabstop=2
setlocal  shiftwidth=2
let g:indent_guides_guide_size = 2

if isGoogle
  augroup AutoFormat
    autocmd FileType go AutoFormatBuffer gofmt
  augroup END
endif
