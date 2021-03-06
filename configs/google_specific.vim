" =================================
" Google Specific
" =================================

if filereadable('/usr/share/vim/google/google.vim')
  source /usr/share/vim/google/google.vim

  " Glug youcompleteme-google
  " not used since I don't really write much python and other languages have
  " ciderlsp.

  " see critique comments
  Glug critique plugin[mappings]

  " causes long hang time due to synchronous action
  " Glug codefmt gofmt_executable="goimports"
  Glug codefmt
  Glug codefmt-google

  " blaze
  Glug blaze plugin[mappings] !alerts
  " only golang is supported, so...
  Glug blazedeps auto_filetypes=`['go']`
endif

" before dream gets its own syntax file, consider them gcl files
autocmd BufNewFile,BufRead *.dream set syntax=gcl
