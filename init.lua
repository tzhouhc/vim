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
  'wellle/targets.vim',
  'andymass/vim-matchup',
  'ggandor/leap.nvim',
  'ggandor/flit.nvim',
  -- visuals
  'lukas-reineke/indent-blankline.nvim',
  'petertriho/nvim-scrollbar',
  'nordtheme/vim',
  'HiPhish/rainbow-delimiters.nvim',
  'akinsho/bufferline.nvim',
  'nvim-lualine/lualine.nvim',
  'norcalli/nvim-colorizer.lua',
  'chrisbra/changesPlugin',
  'lewis6991/gitsigns.nvim',
  'folke/todo-comments.nvim',
  'MunifTanjim/nui.nvim',
  'rcarriga/nvim-notify',
  'folke/twilight.nvim',
  'nvim-treesitter/nvim-treesitter-context',
  'RRethy/vim-illuminate',
  'mhinz/vim-signify',
  -- passives
  'windwp/nvim-autopairs',
  'kylechui/nvim-surround',
  'othree/eregex.vim',
  'bronson/vim-trailing-whitespace',
  'qpkorr/vim-bufkill',
  'folke/which-key.nvim',
  'nacro90/numb.nvim',
  -- tools
  'numToStr/Comment.nvim',
  'nvim-lua/plenary.nvim',
  'FeiyouG/commander.nvim',
  'simrat39/symbols-outline.nvim',
  { 'nvim-telescope/telescope.nvim',            tag = '0.1.6' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-treesitter/nvim-treesitter',
  {
    '2kabhishek/nerdy.nvim',
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
  },
  -- LSPs
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'onsails/lspkind.nvim',
  'L3MON4D3/LuaSnip',
  'VonHeikemen/lsp-zero.nvim',
  'nvim-tree/nvim-web-devicons',
  { 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  -- nvim configuration
  'folke/neodev.nvim',
})

-- variables
vim.api.nvim_set_var('hasNerdfont', vim.env.NERDFONT ~= 'false')
vim.api.nvim_set_var('useSemanticHighlighting', vim.env.VIM_USE_SEMANTIC_HIGHLIGHTING == '1')
-- vw => viw, etc
vim.api.nvim_set_var('visualMoveWholeWord', false)
-- highlight line with cursor
vim.api.nvim_set_var('useCursorLine', true)
-- highlight word (and all matching) under cursor
vim.api.nvim_set_var('highlightCursor', true)
-- status line shows current cursor highlight group
vim.api.nvim_set_var('highlightGroupHint', false)

-- initialize
require('plugins')
require('visuals')
require('mappings')
require('settings')
require('lsp')
require('auto')

vim.cmd("source $HOME/.vim/configs/functions.vim")
vim.opt.runtimepath:append(",~/.vim,~/.vim/local/after")
