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

-- runtime
vim.opt.runtimepath:append(",$VIM_HOME,$VIM_HOME/after,$VIM_HOME/local")

safe_require('lazy').setup({
  defaults = {
    lazy = true,
  },
  -- motion
  -- text targets like "inside quotes"
  'wellle/targets.vim',
  -- % to jump to matching "pair"
  'andymass/vim-matchup',
  -- overall better movement methods
  { 'folke/flash.nvim', config = { modes = { search = { enabled = false } } } },

  -- visuals
  -- create vertical lines to mark indentation.
  'lukas-reineke/indent-blankline.nvim',
  -- icons
  'nvim-tree/nvim-web-devicons',
  -- scrollbar for checking location in file
  'petertriho/nvim-scrollbar',
  -- nord theme
  {
    -- the nvim version of nord theme has better compatibility
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme nord]])
    end,
  },
  -- rainbow colors for parens/brackets for easier depth determination
  'HiPhish/rainbow-delimiters.nvim',
  -- 'tabs'
  {
    'akinsho/bufferline.nvim',
    config = {
      options = {
        show_buffer_close_icons = false,
      }
    },
  },
  -- status bar
  { 'nvim-lualine/lualine.nvim', dependencies = {"meuter/lualine-so-fancy.nvim"}},
  -- highlight hex colors
  { 'norcalli/nvim-colorizer.lua', config = true, cmd = 'ColorizerToggle' },
  -- mark unsaved chages in buffer in gutter; diffs pending changes
  'chrisbra/changesPlugin',
  -- add signs to gutter for marking diffs; only diffs written
  'mhinz/vim-signify',
  -- highlight TODOs
  { 'folke/todo-comments.nvim', config = true },
  -- smart dimming of unrelated contextual code
  { 'folke/twilight.nvim',   config = true, cmd = 'Twilight' },
  -- keep top of code context on screen when scrolling past
  'nvim-treesitter/nvim-treesitter-context',
  -- text objects
  'nvim-treesitter/nvim-treesitter-textobjects',
  -- highlight same token as currently cursored-over
  'RRethy/vim-illuminate',
  -- smarter folding
  { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
  -- notifications
  {
    'folke/noice.nvim',
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- languages
  { 'preservim/vim-markdown', branch = 'master', ft = 'markdown' },
  -- for advanced usage
  -- { 'mrcjkb/rustaceanvim', version = '^4', ft = 'rust' },
  { 'LhKipp/nvim-nu', ft = 'nu', config = { use_lsp_features = false } },

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
  { 'folke/which-key.nvim',   config = true },
  -- don't yank deletion except with 'd'
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = 'd',
    },
  },
  -- automated ctagging
  'ludovicchabant/vim-gutentags',
  -- automatically switch IME for Chinese
  { 'laishulu/vim-macos-ime', ft = { 'text', 'markdown' } },
  -- highlights certain patterns
  { "folke/paint.nvim", ft = { 'markdown' }},

  -- tools
  -- zen mode
  { "folke/zen-mode.nvim", cmd = "ZenMode" },
  -- multiple cursors
  'mg979/vim-visual-multi',
  -- unto tree
  'mbbill/undotree',
  -- regex explainer
  'bennypowers/nvim-regexplainer',
  -- floating terminal
  { 'voldikss/vim-floaterm', cmd = 'FloatermNew' },
  -- git differ
  {
    'sindrets/diffview.nvim',
    config = {
      enhanced_diff_hl = true,
    },
    cmd = 'DiffviewOpen',
  },
  -- quickly toggle line comment
  { 'numToStr/Comment.nvim',         config = true, enabled = function()
    -- neovim 0.10.0 introduces commenting natively
    return vim.version().minor < 10
  end},
  -- library code
  'nvim-lua/plenary.nvim',
  -- custom commands
  { 'FeiyouG/commander.nvim',        config = true },
  -- tree-like code intel for current buffer
  { 'simrat39/symbols-outline.nvim', config = true, cmd = "SymbolsOutline" },
  -- quick jump to locally or globally recorded locations
  "otavioschwanck/arrow.nvim",
  -- tool for searching stuff
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
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
    cmd = 'Oil',
  },
  {
    -- query devdocs inside vim
    "tzhouhc/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "DevdocsOpenCurrentFloat",
  },

  -- applications
  -- filesystem sidebar
  {
    'nvim-tree/nvim-tree.lua',
    config = true,
    cmd = 'NvimTreeToggle'
  },

  -- LSPs
  { 'williamboman/mason.nvim',                  config = true },
  { 'williamboman/mason-lspconfig.nvim',        config = true },
  'rafamadriz/friendly-snippets',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'onsails/lspkind.nvim',
  'VonHeikemen/lsp-zero.nvim',
  'nvimtools/none-ls.nvim',
  { 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, cmd = 'TroubleToggle' },

  -- nvim configuration development
  { 'folke/neodev.nvim',  config = true },
})

-- the following do not make require calls:
-- visual effects
safe_require('visuals')

-- the following involves requiring other modules:
-- autocommands
safe_require('autocmds')
-- filetypes recognition
safe_require('files')
-- plugin configurations
safe_require('plugins')
-- keymaps
safe_require('mappings')
-- vim options
safe_require('settings')
-- completion and language services
safe_require('lsp')
-- commander
safe_require('commands')
