-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
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
    { import = "plugins.debug" },
    { import = "plugins.intel" },
    { import = "plugins.tools" },
  },
  profiling = {
    require = true,
  },
})
