" ======================
" Auto Commands
" ======================

augroup extensions
  au!
  if isGoogle
    autocmd BufNewFile,BufRead *.pp set syntax=gcl
  endif
augroup END

augroup templates
  au!
  autocmd BufNewFile *.rb 0r ~/.vim/templates/template.rb
augroup END

if !isLeanVim
  augroup gutentags_status
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
  augroup END
endif
