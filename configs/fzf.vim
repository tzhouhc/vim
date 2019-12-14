" PREVIEWS!
" Buffer Tag previews with some modifications so that it has both coloring as
" well as correct alignment to the line with the keyword

" Do not attempt to DRY this up by extracting the dict -- it gets modified or
" something, causing subsequent calls to be without previews whatsoever.
command! -bang -nargs=* BTags
  \ call fzf#vim#buffer_tags(<q-args>, {
  \     'down': '40%',
  \     'options': '--delimiter="\t"
  \                 --with-nth 1
  \                 --reverse
  \                 --preview-window="60%"
  \                 --preview "
  \                     ln=\$(echo {3} | sed \"s/[^0-9]//g\" );
  \                     bat -H \$ln
  \                     -r \$((\$[\$ln-3] < 0 ? 0 : \$[\$ln-3])):\$[\$ln+20]
  \                     {2}"'
  \ }, <bang>0)

command! -bang -nargs=* Tags
  \ call fzf#vim#tags(<q-args>, {
  \     'down': '40%',
  \     'options': '--delimiter="\t"
  \                 --with-nth 1
  \                 --reverse
  \                 --preview-window="60%"
  \                 --preview "
  \                     ln=\$(echo {-2} | sed \"s/^line\://\" );
  \                     bat -H \$ln
  \                     -r \$((\$[\$ln-3] < 0 ? 0 : \$[\$ln-3])):\$[\$ln+20]
  \                     {2}"'
  \ }, <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
  \   'down': '40%',
  \   'options':
  \     '--reverse
  \      --preview-window="60%"
  \      --preview "
  \        bat {} -r :40"'
  \ }),
  \ <bang>0)

" History preview with colorings and such
" Post-Portem 2019/11/24: Bash 3.2.57(1) for darwin19 (Catalina) has a shell
" var substitution bug that causes this to fail. Updating bash fixes the
" issue.
command! -bang -nargs=* History
  \ call fzf#vim#history(fzf#vim#with_preview({
  \   'down': '40%',
  \   'options':
  \     '--reverse
  \      --preview-window="60%"
  \      --preview "
  \        bat {} -r :40"'}),
  \   <bang>0)

" Local recursive text search
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({
  \   'down': '40%',
  \   'options':
  \     '--reverse
  \      --preview-window="60%"
  \      --preview "
  \        bat {} -r :40"'}),
  \   <bang>0)
