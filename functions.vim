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
