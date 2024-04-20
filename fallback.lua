-- Init.vim
-- Ting's custom NeoVim configurations.

-- initialize
-- setup "safe_require" so that nvim doesn't break if any one plugin was
-- slightly misconfigured.
local safe_require = require('lib.meta').safe_require

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true

require('lazy').setup({
  -- motion
  -- text targets like "inside quotes"
  'wellle/targets.vim',
  -- % to jump to matching "pair"
  'andymass/vim-matchup',
  -- quick jump on screen; supports visual mode
  'easymotion/vim-easymotion',
  -- better f/F and t/T
  {
    'ggandor/flit.nvim',
    config = true,
    dependencies = { 'ggandor/leap.nvim' },
  },

  -- visuals
  -- nord theme
  'nordtheme/vim',
  -- 'tabs'
  'akinsho/bufferline.nvim',
  -- status bar
  'nvim-lualine/lualine.nvim',
  -- keep top of code context on screen when scrolling past
  'nvim-treesitter/nvim-treesitter-context',

  -- passives
  -- automatically close/add pairs
  { 'windwp/nvim-autopairs',  config = true },
  -- y/d/s for pairs at once
  { 'kylechui/nvim-surround', config = true },
  -- removing trailing whitespaces on save
  'bronson/vim-trailing-whitespace',
  -- kill buffer but keep split
  'qpkorr/vim-bufkill',
  -- don't yank deletion except with 'd'
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = 'd',
    },
  },

  -- tools
  -- library code
  'nvim-lua/plenary.nvim',
  -- quickly toggle line comment
  { 'numToStr/Comment.nvim', config = true },
  -- tool for searching stuff
  { 'nvim-telescope/telescope.nvim',            tag = '0.1.6' },
  -- with fzf
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- semantic parser
  'nvim-treesitter/nvim-treesitter',
})

-- lsp is not loaded
safe_require('fallback.plugins')
safe_require('fallback.visuals')
safe_require('fallback.mappings')
safe_require('fallback.settings')
safe_require('fallback.auto')

-- runtime
vim.opt.runtimepath:append(",~/.vim,~/.vim/after,~/.vim/local")
