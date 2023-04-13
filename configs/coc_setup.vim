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

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" goto places
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>
nnoremap <silent> <leader>rn <Plug>(coc-rename)

" navigate between errors
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" format selected code
xmap <silent> gf  <Plug>(coc-format-selected)
nmap <silent> gf  <Plug>(coc-format)

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
      \   'noselect': v:true,
      \   'enablePreview': v:true,
      \   'enablePreselect': v:false,
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
