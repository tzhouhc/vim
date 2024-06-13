-- gutentags
local vim_home = os.getenv("VIM_HOME")
if vim_home == nil then
  local home = os.getenv("HOME")
  vim_home = home .. "/.config/nvim"
end

vim.g.gutentags_cache_dir = vim_home .. "/tags"
-- custom tag file list using fd; see rest of dotfiles
vim.g.gutentags_file_list_command = "gutentagger"
vim.g.gutentags_resolve_symlinks = 1
vim.g.gutentags_define_advanced_commands = 1
