" =================================
" Google Specific
" =================================

source /usr/share/vim/google/google.vim
" Glug youcompleteme-google
Glug critique plugin[mappings]

Glug codefmt gofmt_executable="goimports"
Glug codefmt-google

" blaze
Glug blaze plugin[mappings] !alerts
Glug blazedeps auto_filetypes=`['go']`

" before dream gets its own syntax file, consider them gcl files
autocmd BufNewFile,BufRead *.dream set syntax=gcl
