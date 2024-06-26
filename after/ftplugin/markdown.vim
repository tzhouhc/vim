" in markdown, comment leaders are '*'s and such; it would not
" be good to reinsert them automatically.
" yet, we still want to make sure that if we *manually* breaking the line by
" using either `Enter` or `o` or `O`, that we do indeed get another bullet
" point. I.e. we only want a new line when we *ask* for it.
set autoindent
set formatoptions=crnojqw

" set conceallevel=2
" set concealcursor=nc
set tw=80
set wrapmargin=0
set formatoptions+=t
set linebreak
set spelllang=en

" not working due to misinterpretation of the S from vim-surround;
" vnoremap <c-i> S*
" vnoremap <c-b> S*gvS*
