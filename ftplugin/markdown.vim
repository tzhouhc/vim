" in markdown, comment leaders are '*'s and such; it would not
" be good to reinsert them automatically.
set formatoptions-=c
" yet, we still want to make sure that if we *manually* breaking the line by
" using either `Enter` or `o` or `O`, that we do indeed get another bullet
" point. I.e. we only want a new line when we *ask* for it.
set autoindent
set formatoptions+=awnro

set conceallevel=2
set concealcursor=nc
set tw=80
set spelllang=en
setlocal spell
