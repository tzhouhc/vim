-- Init.vim
-- Ting's custom Neovim configurations.

-- set leader as Lazy expects it before setting up plugins
vim.g.mapleader = "\\"

-- specific local configurations that should not be version-controlled
require("local")

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

-- setup various plugins with autoreload
require("lazy").setup({
  spec = {
    { import = "plugins.ui" },
    { import = "plugins.passive" },
    { import = "plugins.visual" },
    { import = "plugins.git" },
    { import = "plugins.editing" },
    { import = "plugins.intel" },
    { import = "plugins.tools" },
  },
  profiling = {
    require = true,
  },
})
-- general vim settings unrelated to plugins
require("conf")
-- plugin post-loading configurations (i.e. needs `require` from the plugin)
require("post")
-- specific local configurations that should not be version-controlled, but
-- requires plugins
require("local_post")
