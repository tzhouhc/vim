vim.filetype.add({
  extension = {
    nu = 'nu',
  },
  filename = {
    ['justfile'] = 'just',
    ['.justfile'] = 'just',
    ['notes'] = 'markdown',
  },
})
