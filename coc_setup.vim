" =================
" Coc-nvim
" =================

function! CocActionAsync(...) abort
  return s:AsyncRequest('CocAction', a:000)
endfunction

function! CocRequestAsync(...)
  return s:AsyncRequest('sendRequest', a:000)
endfunction

function! s:AsyncRequest(name, args) abort
  let Cb = a:args[len(a:args) - 1]
  if type(Cb) == 2
    if !coc#rpc#ready()
      call Cb('service not started', v:null)
    else
      call coc#rpc#request_async(a:name, a:args[0:-2], Cb)
    endif
    return ''
  endif
  call coc#rpc#notify(a:name, a:args)
  return ''
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" goto places
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>

augroup EditVim
  autocmd!
  autocmd filetype crontab setlocal nobackup nowritebackup
  "autocmd filetype python setlocal completeopt-=preview
  autocmd CursorHold * silent call CocActionAsync('doHover')
augroup END

" ==============================
" Context-sensitive Coc Config
" ==============================

" base settings
let g:coc_user_config = {
      \ 'coc.preferences': {
      \   'formatOnSaveFiletypes': [],
      \   'colorSupport': v:true,
      \   'hoverTarget': 'float',
      \   'jumpCommand': 'edit',
      \ },
      \ 'suggest': {
      \   'autoTrigger': 'always',
      \   'triggerAfterInsertEnter': v:true,
      \   'localityBonus': v:true,
      \   'noSelect': v:false,
      \   'enablePreview': v:true,
      \   'enablePreselect': v:true,
      \   'numberSelect': v:false,
      \   'floatEnable': v:true,
      \   'acceptSuggestionOnCommitCharacter': v:true,
      \ },
      \ 'diagnostic': {
      \   'checkCurrentLine': v:true,
      \   'virtualText': v:true,
      \   'virtualTextPrefix': ' ⬩ ',
      \   'enableSign': v:true,
      \   'refreshOnInsertMode': v:true,
      \   'errorSign': 'x',
      \   'warningSign': '!',
      \   'infoSign': '?',
      \   'hintSign': '·',
      \   'level': 'information',
      \ }
      \}

if isGoogle
  " Google mode configs
  let g:coc_user_config.languageserver = {
      \   'ciderlsp': {
      \     'command': '/google/bin/releases/editor-devtools/ciderlsp',
      \     'args': [
      \       '--tooltag=coc-nvim',
      \       '--noforward_sync_responses'
      \     ],
      \     'filetypes': [
      \       'c',
      \       'cpp',
      \       'proto',
      \       'textproto',
      \       'go'
      \     ]
      \   },
      \   'kythe': {
      \     'command': '/google/bin/releases/grok/tools/kythe_languageserver',
      \     'args': [
      \       '--google3'
      \     ],
      \     'filetypes': [
      \       'python',
      \       'go',
      \       'java',
      \       'cpp',
      \       'proto'
      \     ]
      \   }
      \ }
else
  " 'civilian' mode configs
  let g:coc_user_config.languageserver = {}
  " coc-sh doesn't really have any settings
  "
  " requires coc-solarpraph
  if executable('solargraph')
    let g:coc_user_config.solargraph = {
        \  'diagnostics': v:true
        \}
  endif
  " requires coc-python
  if executable('black')
    let g:coc_user_config.python = {
        \  'formatting.provider': 'black',
        \  'linting.flake8Enabled': v:true,
        \}
  endif
  " requires coc-latex
  if executable('latexmk')
    let g:coc_user_config.latex = {
        \  'build': {
        \    'onSave': v:true,
        \  },
        \  'forwardSearch': {
        \    'executable': 'open',
        \  },
        \}
  endif
  " ----------------
  " non-coc language servers
  if executable('gopls')
    let g:coc_user_config.languageserver.gopls = {
      \  'command': 'gopls',
      \  'filetypes': ['go'],
      \  'ignoredRootPaths': ['go.mod']
      \}
  endif
endif
