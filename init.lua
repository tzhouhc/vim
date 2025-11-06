-- Ting's custom Neovim configurations.

-- general vim settings unrelated to plugins
require("conf")

-- plguins, managed by Lazy.nvim
require("plugins")

-- plugin post-loading configurations (i.e. needs `require` from the plugin)
require("post")

-- autocmds
require("autocmds")

-- `lua/lib` includes custom logic (with or w/o plugin API usage) that are
-- not loaded by default, but are imported by their corresponding plugins or
-- post conf scripts.

-- `lua/after` includes filetype and LSP based configurations that are
-- automatically loaded by neovim in the right cimcumstances.

-- `snippets` are personal snippets for use with nvim-cmp-vsnip.
