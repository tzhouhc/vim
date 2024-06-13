-- Init.vim
-- Ting's custom Neovim configurations.

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

require("lazy").setup("plugins")

-- the following do not make require calls:
-- visual effects
require("visuals")

-- the following involves requiring other modules:
-- autocommands
require("autocmds")
-- filetypes recognition
require("files")
-- plugin post-loading configurations (i.e. needs `require` from the plugin)
require("post")
-- keymaps
require("mappings")
-- vim options
require("settings")
-- language services
require("lsp")
-- completions via nvim-cmp
require("completions")
-- commander
require("commands")
