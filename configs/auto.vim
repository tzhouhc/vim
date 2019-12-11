" ======================
" Auto Commands
" ======================

augroup vimrc
  au!
  " keep a history of visited files because shadas are stupid
  autocmd BufRead * silent! execute "!echo '%:p' >> ~/.vim/vim_history && sort ~/.vim/vim_history | uniq | tee ~/.vim/vim_history" | redraw!
augroup END

augroup templates
  au!
  autocmd BufNewFile *.rb 0r ~/.vim/templates/template.rb
augroup END

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
augroup END

augroup gutentags_status
            autocmd!
            autocmd User GutentagsUpdating call lightline#update()
            autocmd User GutentagsUpdated call lightline#update()
augroup END
