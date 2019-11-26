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

call textobj#user#plugin('strings', {
\   'single': {
\     'pattern': "'[^']*'",
\     'select': ["a'"],
\   },
\   'double': {
\     'pattern': '"[^"]*"',
\     'select': ['a"'],
\   },
\ })
