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
