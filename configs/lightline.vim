let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'g4d', 'pwd' ],
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'filetype' ],
    \              [ 'fileencoding' ],
    \              [ 'percent', 'lineinfo' ]
    \   ]
    \ },
    \ 'tabline': {
    \   'left': [ [ 'buffers' ] ],
    \   'right': [ [ 'tabs' ] ]
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ 'component': {
    \ },
    \ 'component_function': {
    \   'g4d': 'G4dName',
    \   'pwd': 'Pwd',
    \   'gutentags': 'gutentags#statusline',
    \   'hl': 'SynStack',
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ },
    \ }

let g:lightline#bufferline#enable_devicons = 1
" want to figure out how to customize pathshorten
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

let g:lightline#bufferline#show_number = 2
if hasNerdfont
  let g:lightline#bufferline#modified = " "
  let g:lightline#bufferline#unamed = ""
else
  let g:lightline#bufferline#modified = " *"
  let g:lightline#bufferline#unamed = " ?"
endif
let g:lightline#bufferline#clickable = 1
let g:lightline.component_raw = {'buffers': 1}

if highlightGroupHint
  let g:lightline['active']['right'][2] = ['hl', 'percent', 'lineinfo']
endif
