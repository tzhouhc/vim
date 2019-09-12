" ======================
" Auto Commands
" ======================

augroup vimrc
  au!
  autocmd BufEnter * call AutoGoyo()
  " keep a history of visited files because shadas are stupid
  autocmd BufRead * silent! execute "!echo '%:p' >> ~/.vim/vim_history && sort ~/.vim/vim_history | uniq | tee ~/.vim/vim_history" | redraw!
augroup END
