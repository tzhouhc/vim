" ============================
" functions
" ============================
function! Multiple_cursors_before()
    echo 'Disabled autocomplete'
endfunction

function! ToggleNERDTreeFind()
  if exists('g:NERDTree.IsOpen')
    if g:NERDTree.IsOpen()
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
  else
    execute ':NERDTreeFind'
  endif
endfunction

function! Buildifier(buffer)
  return {
        \  'command': 'buildifier'
        \}
endfunction

function! G4dName()
  let name = expand("%:p")
  if name  =~ "^/google/src/cloud/[^/]*/[^/]*/"
    return split(name, '/')[4]
  endif
  return ""
endfunction

function! Pwd()
  let path = fnamemodify(expand("%"), ':p:~:h')
  if path  =~ "^/google/src/cloud/[^/]*/[^/]*/"
    return join(split(path, '/')[5:], "/")
  endif
  return path
endfunction
