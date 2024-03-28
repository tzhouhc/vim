" ======================
" Auto Commands
" ======================

augroup templates
  au!
  autocmd BufNewFile *.rb 0r ~/.vim/templates/template.rb
augroup END

augroup gutentags_status
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END

if highlightCursor
  augroup highlight_cursor_word
    autocmd! CursorMoved * exe printf('match Underline /\V\<%s\>/', escape(expand('<cword>'), '/\'))
  augroup END
endif

augroup formatting
  au!
  autocmd BufWritePost * FixWhitespace
augroup END
