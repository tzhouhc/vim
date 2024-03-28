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
  "wellle/targets.vim",
  "andymass/vim-matchup",
  "folke/flash.nvim",
  -- visuals
  "lukas-reineke/indent-blankline.nvim",
  "petertriho/nvim-scrollbar",
  "arcticicestudio/nord-vim",
  "HiPhish/rainbow-delimiters.nvim",
  "akinsho/bufferline.nvim",
  "nvim-lualine/lualine.nvim",
  "chrisbra/changesPlugin",
  "lewis6991/gitsigns.nvim",
  "folke/todo-comments.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "folke/twilight.nvim",
  "folke/noice.nvim",
  "nvim-treesitter/nvim-treesitter-context",
  "RRethy/vim-illuminate",
  -- passives
  "windwp/nvim-autopairs",
  "kylechui/nvim-surround",
  "othree/eregex.vim",
  "bronson/vim-trailing-whitespace",
  "qpkorr/vim-bufkill",
  "folke/which-key.nvim",
  -- tools
  "ibhagwan/fzf-lua",
  "numToStr/Comment.nvim",
  "nvim-treesitter/nvim-treesitter",
  -- LSPs
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "VonHeikemen/lsp-zero.nvim",
  "nvim-tree/nvim-web-devicons",
  "folke/trouble.nvim",
  -- nvim configuration
  "folke/neodev.nvim",
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

vim.cmd("source $HOME/.vim/configs/functions.vim")
vim.cmd("source $HOME/.vim/configs/auto.vim")
vim.opt.runtimepath:append(",~/.vim,~/.vim/local/after")
