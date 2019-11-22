" maps 'q' as 'letter series'
" so as to allow selecting chunks in a snake-case word
call textobj#user#plugin('letters', {
\   'base': {
\     'pattern': '\v[a-zA-Z]+',
\     'select': ['iq', 'q'],
\   },
\   'with_underscores': {
\     'pattern': '\v[a-zA-Z]+_*',
\     'select': ['aq'],
\   },
\ })

" select from inside of weird surrounds
" -- credit /u/-romainl-
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#', ' ' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
