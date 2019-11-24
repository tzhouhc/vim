" PREVIEWS!
" Buffer Tag previews with some modifications so that it has both coloring as
" well as correct alignment to the line with the keyword

" Do not attempt to DRY this up by extracting the dict -- it gets modified or
" something, causing subsequent calls to be without previews whatsoever.
command! -bang -nargs=* BTags
  \ call fzf#vim#buffer_tags(<q-args>, {
  \     'down': '30%',
  \     'options': '--with-nth 1
  \                 --reverse
  \                 --preview-window="60%"
  \                 --preview "
  \                     bat --color always {2} |
  \                     tail -n +\$(echo {3} | tr -d \";\\\"\") |
  \                     tail -n +4 |
  \                     head -n 16"'
  \ }, <bang>0)

command! -bang -nargs=* Tags
  \ call fzf#vim#tags(<q-args>, {
  \     'down': '30%',
  \     'options': '--with-nth 1
  \                 --reverse
  \                 --preview-window="60%"
  \                 --preview "
  \                     bat --style=changes --color always {2} |
  \                     tail -n +\$(echo {-2} | sed "s/^line\://") |
  \                     head -n 16"'
  \ }, <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
  \   'down': '30%',
  \   'options':
  \     '--reverse
  \      --preview-window="60%"
  \      --preview "
  \        bat --style=changes --color always {} | head -16"'
  \ }),
  \ <bang>0)

" History preview with colorings and such
command! -bang -nargs=* History
  \ call fzf#vim#history({
  \   'down': '30%',
  \   'options':
  \     '--reverse
  \      --preview-window="60%"
  \      --preview "
  \        bat --style=changes --color always {} | head -16"'
  \ }, <bang>0
  \ )
