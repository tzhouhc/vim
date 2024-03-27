vim.g.mapleader = "\\"

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
  "easymotion/vim-easymotion",
  "andymass/vim-matchup",
  -- visuals
  "petertriho/nvim-scrollbar",
  "arcticicestudio/nord-vim",
  -- passives
  "Raimondi/delimitMate",
  "tpope/vim-surround",
  "othree/eregex.vim",
  "bronson/vim-trailing-whitespace",
  "qpkorr/vim-bufkill",
  -- tools
  "tpope/vim-commentary",
  "unblevable/quick-scope",
  -- LSPs
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "VonHeikemen/lsp-zero.nvim",
  "nvim-tree/nvim-web-devicons",
  "folke/trouble.nvim",
  -- nvim configuration
  "folke/neodev.nvim",
})

require('visuals')
require('mappings')
require('settings')
require('lsp')
