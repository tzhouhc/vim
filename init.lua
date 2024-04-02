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
  -- better f/F and t/T
  'ggandor/leap.nvim',
  -- quick jump on screen using two char as beacon
  { 'ggandor/flit.nvim',         config = true },

  -- visuals
  {
    -- create vertical lines to mark indentation.
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup()
    end,
  },
  -- scrollbar for checking location in file
  { 'petertriho/nvim-scrollbar', config = true },
  -- nord theme
  'nordtheme/vim',
  -- smooth scrolling
  { 'karb94/neoscroll.nvim',       config = true },
  -- rainbow colors for parens/brackets for easier depth determination
  'HiPhish/rainbow-delimiters.nvim',
  -- 'tabs'
  'akinsho/bufferline.nvim',
  -- status bar
  'nvim-lualine/lualine.nvim',
  -- highlight hex colors
  { 'norcalli/nvim-colorizer.lua', config = true },
  -- mark unsaved chages in buffer in gutter
  'chrisbra/changesPlugin',
  -- highlight TODOs
  'folke/todo-comments.nvim',
  -- smart dimming of unrelated contextual code
  { 'folke/twilight.nvim',    config = true },
  -- keep top of code context on screen when scrolling past
  'nvim-treesitter/nvim-treesitter-context',
  -- highlight same token as currently cursored-over
  'RRethy/vim-illuminate',
  -- add signs to gutter for marking diffs
  'mhinz/vim-signify',
  -- smarter folding
  { 'kevinhwang91/nvim-ufo',  dependencies = 'kevinhwang91/promise-async' },

  -- passives
  -- automatically close/add pairs
  { 'windwp/nvim-autopairs',  config = true },
  -- y/d/s for pairs at once
  { 'kylechui/nvim-surround', config = true },
  -- use pcre for searching (replacement uses S instead of s)
  'othree/eregex.vim',
  -- removing trailing whitespaces on save
  'bronson/vim-trailing-whitespace',
  -- kill buffer but keep split
  'qpkorr/vim-bufkill',
  -- helps remembering things like registers
  { 'folke/which-key.nvim', config = true },
  -- better 0
  { 'yuki-yano/zero.nvim',  config = true },
  -- don't yank deletion except with 'm'
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = 'm',
    },
  },

  -- tools
  -- quickly toggle line comment
  { 'numToStr/Comment.nvim',                    config = true },
  -- library code
  'nvim-lua/plenary.nvim',
  -- custom commands
  'FeiyouG/commander.nvim',
  -- tree-like code intel for current buffer
  { 'simrat39/symbols-outline.nvim',            config = true },
  -- tool for searching stuff
  { 'nvim-telescope/telescope.nvim',            tag = '0.1.6' },
  -- with fzf
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- semantic parser
  'nvim-treesitter/nvim-treesitter',
  {
    -- nerdfont glyph telescope
    '2kabhishek/nerdy.nvim',
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- LSPs
  { 'williamboman/mason.nvim',           config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true },
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'onsails/lspkind.nvim',
  'L3MON4D3/LuaSnip',
  'VonHeikemen/lsp-zero.nvim',
  'nvim-tree/nvim-web-devicons',
  { 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },

  -- nvim configuration development
  { 'folke/neodev.nvim',  config = true },
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