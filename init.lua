-- Init.vim
-- Ting's custom Neovim configurations.

-- set leader as Lazy expects it before setting up plugins
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

-- runtime
vim.opt.runtimepath:append(",$VIM_HOME,$VIM_HOME/after,$VIM_HOME/local")

-- setup various plugins with autoreload
require("lazy").setup("plugins")
-- general vim settings unrelated to plugins
require("conf")
-- plugin post-loading configurations (i.e. needs `require` from the plugin)
require("post")
