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
nnoremap <silent> <leader>rn <Plug>(coc-rename)

" navigate between errors
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" format selected code
xmap <silent> gf  <Plug>(coc-format-selected)
nmap <silent> gf  <Plug>(coc-format)

" rename variable
nmap <leader>rn <Plug>(coc-rename)

augroup EditVim
  autocmd!
  autocmd filetype crontab setlocal nobackup nowritebackup
  " autocmd filetype python setlocal completeopt-=preview

  " The issue with auto doHover is that the resulting extreme frequency of
  " hover requests and failure counts.
  " autocmd CursorHold * silent call CocActionAsync('doHover')
augroup END

" ==============================
" Context-sensitive Coc Config
" ==============================

" base settings
let g:coc_user_config = {
      \ 'coc.preferences': {
      \   'formatOnSaveFiletypes': ['rust'],
      \   'colorSupport': v:true,
      \   'hoverTarget': 'float',
      \   'jumpCommand': 'edit',
      \   'echodocSupport': v:true,
      \ },
      \ 'coc.source': {
      \   'file': v:true,
      \ },
      \ 'suggest': {
      \   'completionItemKindLabels': {
      \ 	'keyword': "\uf1de",
      \ 	'variable': "\ue79b",
      \ 	'value': "\uf89f",
      \ 	'operator': "\u03a8",
      \ 	'function': "\u0192",
      \ 	'reference': "\ufa46",
      \ 	'constant': "\uf8fe",
      \ 	'method': "\uf09a",
      \ 	'struct': "\ufb44",
      \ 	'class': "\uf0e8",
      \ 	'interface': "\uf417",
      \ 	'text': "\ue612",
      \ 	'enum': "\uf435",
      \ 	'enumMember': "\uf02b",
      \ 	'module': "\uf40d",
      \ 	'color': "\ue22b",
      \ 	'property': "\ue624",
      \ 	'field': "\uf9be",
      \ 	'unit': "\uf475",
      \ 	'event': "\ufacd",
      \ 	'file': "\uf723",
      \ 	'folder': "\uf114",
      \ 	'snippet': "\ue60b",
      \ 	'typeParameter': "\uf728",
      \ 	'default': "\uf29c"
      \   },
      \   'autoTrigger': 'always',
      \   'triggerAfterInsertEnter': v:true,
      \   'localityBonus': v:true,
      \   'noSelect': v:false,
      \   'enablePreview': v:true,
      \   'enablePreselect': v:true,
      \   'echodocSupport': v:true,
      \   'numberSelect': v:false,
      \   'floatEnable': v:true,
      \   'removeDuplicateItems': v:true,
      \   'acceptSuggestionOnCommitCharacter': v:true,
      \ },
      \ 'source': {
      \   'module.enable': v:false,
      \ },
      \ 'snippets': {
      \   'userSnippetsDirectory': "~/.vim/snippets",
      \   'snipmate.enable': v:false,
      \   'ultisnips.enable': v:false,
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
      \   'level': 'hint',
      \ }
      \}

if isGoogle
  " Google mode configs
  call coc#config('coc-ciderlsp.filetypes', [
    \                 "cpp",
    \                 "python",
    \                 "borg",
    \                 "go",
    \                 "java",
    \                 "proto",
    \                 "bzl",
    \                 "javascript",
    \                 "typescript",
    \                 "gcl",
    \                 "textproto"
    \         ])
  call coc#config('coc-ciderlsp.args', [
    \                 "--tooltag=coc-nvim",
    \                 "--noforward_sync_responses"
    \         ])
  call coc#config('coc-ciderlsp.enabled', v:true)
  call coc#config('coc-ciderlsp.compose.enabled', v:true)
  let g:coc_filetype_map = {
      \   'dream': 'borg'
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
        \  'jediEnabled': v:true,
        \  'pythonPath': '/usr/local/bin/python3',
        \  'linting.enabled': v:true,
        \  'linting.pylintEnabled': v:false,
        \  'linting.pylintArgs': ["--init-hook='import sys; sys.path.append(\".\")'"],
        \  'linting.flake8Enabled': v:true,
        \  'linting.mypyEnabled': v:true,
        \}
    let g:coc_user_config['coc.preferences']['formatOnSaveFiletypes'] = []
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
  " ----------------
  let g:coc_user_config['rust-client'] = {
        \  'revealOutputChannelOn': 'error',
        \}
endif
