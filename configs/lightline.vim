let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'g4d', 'pwd' ],
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'gutentags' ],
    \              [ 'filetype' ],
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
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ },
    \ }

