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
