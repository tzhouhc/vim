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

safe_require('lazy').setup({
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
  { 'karb94/neoscroll.nvim',     config = true },
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
  { 'folke/twilight.nvim',         config = true },
  -- keep top of code context on screen when scrolling past
  'nvim-treesitter/nvim-treesitter-context',
  -- text objects
  'nvim-treesitter/nvim-treesitter-textobjects',
  -- highlight same token as currently cursored-over
  'RRethy/vim-illuminate',
  -- add signs to gutter for marking diffs
  'mhinz/vim-signify',
  -- smarter folding
  { 'kevinhwang91/nvim-ufo',  dependencies = 'kevinhwang91/promise-async' },
  -- notifications
  { 'folke/noice.nvim', dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }} ,

  -- languages
  { 'preservim/vim-markdown', branch = 'master' },

  -- passives
  -- automatically close/add pairs
  { 'windwp/nvim-autopairs',  config = true },
  -- y/d/s for pairs at once
  { 'kylechui/nvim-surround', config = true },
  -- removing trailing whitespaces on save
  'bronson/vim-trailing-whitespace',
  -- kill buffer but keep split
  'qpkorr/vim-bufkill',
  -- helps remembering things like registers
  { 'folke/which-key.nvim',  config = true },
  -- don't yank deletion except with 'd'
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = 'd',
    },
  },
  -- automated ctagging
  'ludovicchabant/vim-gutentags',

  -- tools
  -- multiple cursors
  'mg979/vim-visual-multi',
  -- git differ
  'sindrets/diffview.nvim',
  -- quickly toggle line comment
  { 'numToStr/Comment.nvim', config = true },
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
    -- editing filesystem like a buffer
    'stevearc/oil.nvim',
    opts = {},
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- applications
  -- filesystem sidebar
  { 'nvim-tree/nvim-tree.lua',           config = true },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Vault",
          path = "~/Documents/Vault",
        },
      },
    },
  },

  -- LSPs
  { 'williamboman/mason.nvim',           config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true },
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'onsails/lspkind.nvim',
  'L3MON4D3/LuaSnip',
  'VonHeikemen/lsp-zero.nvim',
  'nvim-tree/nvim-web-devicons',
  { 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },

  -- nvim configuration development
  { 'folke/neodev.nvim',  config = true },
})

safe_require('plugins')
safe_require('visuals')
safe_require('mappings')
safe_require('settings')
safe_require('lsp')
safe_require('auto')

-- runtime
vim.opt.runtimepath:append(",~/.vim,~/.vim/after,~/.vim/local")
