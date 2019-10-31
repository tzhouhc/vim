" =================================
" Google Specific
" =================================

if filereadable('/usr/share/vim/google/google.vim')
  source /usr/share/vim/google/google.vim
  " Glug youcompleteme-google
  Glug critique plugin[mappings]

" causes long hang time due to synchronous action
" Glug codefmt gofmt_executable="goimports"
" Glug codefmt-google

  " blaze
  Glug blaze plugin[mappings] !alerts
  Glug blazedeps auto_filetypes=`['go']`
endif

" before dream gets its own syntax file, consider them gcl files
autocmd BufNewFile,BufRead *.dream set syntax=gcl
