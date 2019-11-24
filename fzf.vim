" with PREVIEWS!
" Buffer Tag previews with some modifications so that it has both coloring as
" well as correct alignment to the line with the keyword
let buf_tags_style = {
  \     'down': '30%',
  \     'options': '--with-nth 1
  \                 --reverse
  \                 --preview-window="60%"
  \                 --preview "
  \                     bat --color always {2} |
  \                     tail -n +\$(echo {3} | tr -d \";\\\"\") |
  \                     tail -n +4 |
  \                     head -n 16"'
  \ }

let tags_style = {
  \     'down': '30%',
  \     'options': '--with-nth 1
  \                 --reverse
  \                 --preview-window="60%"
  \                 --preview "
  \                     bat --style=changes --color always {2} |
  \                     head -n 16"'
  \ }

let files_style = {
  \   'down': '30%',
  \   'options':
  \     '--reverse
  \      --preview-window="60%"
  \      --preview "
  \        bat --style=changes --color always {} | head -16"'
  \ }

command! -bang BTags
  \ call fzf#vim#buffer_tags('', buf_tags_style)

command! -bang Tags
  \ call fzf#vim#tags(<q-args>, tags_style)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(files_style),
  \ <bang>0)

" History preview with colorings and such
command! -bang -nargs=* History
  \ call fzf#vim#history(files_style,
  \ )

