-- NeoVim Global Keyed Options

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.stal = 2
vim.opt.showcmd = true
vim.opt.inccommand = "split"

-- tab completion for commands
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
--
-- saves time by not frequently redrawing stuff
vim.opt.lazyredraw = true
vim.opt.showmatch = true
-- pwd is always current file -- helpful for ctrl-o
-- (doesn't always work well with telescope?)
vim.opt.autochdir = true

-- searching
vim.opt.incsearch = true
-- check case when query has uppercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- mouse use
vim.opt.mouse = "a"

-- cursor wrap
vim.opt.whichwrap = "<,>,[,]"

-- encoding
vim.opt.encoding="UTF-8"

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- highlight line with cursor
vim.opt.cursorline = true

-- folding (note -- number due to effect of plugin "ufo")
vim.opt.foldenable = true
vim.opt.foldlevelstart = 20
vim.opt.foldcolumn = '1'
vim.opt.foldlevelstart = 20
vim.opt.foldmethod="indent"

-- switch buffer without saving
vim.opt.hidden = true

-- diffing
vim.opt.diffopt:append("algorithm:patience")

-- command area height and 'hit-enter' message prevention
vim.opt.cmdheight = 1
vim.opt.shortmess = "laoOAIcCF"
vim.opt.shortmess= "aFc"

-- Keep undo history across sessions by storing it in a file
vim.opt.undofile = true

vim.opt.tags = "~/.vim/tags"

-- ShaDa file -- controlling viminfo behavior
-- ' -> marked files (file history)
-- f -> global marks?
-- < -> saved lines for registers
-- : -> number of lines to save from the command line history
-- @ -> number of lines to save from the input line history
-- / -> number of lines to save from the search history
-- r -> removable media, for which no marks will be stored (can be
--   used several times)
-- ! -> global variables that start with an uppercase letter and
--   don't contain lowercase letters
-- h -> disable 'hlsearch' highlighting when starting
-- % -> the buffer list (only restored when starting Vim without file
--   arguments)
-- c -> convert the text using 'encoding'
-- n -> name used for the ShaDa file (must be the last option)
vim.opt.shada="'50,f1,<500,:100,@40,/20,n~/.vim/main.shada"