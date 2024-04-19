-- Custom Telescopes Setup

local scopes = require('lib.scopes')

vim.api.nvim_create_user_command('Runtimes', scopes.runtime_files, {})
vim.api.nvim_create_user_command('VimConfigs', scopes.find_configs, {})
vim.api.nvim_create_user_command('Dotfiles', scopes.find_dotfiles, {})
