-- Store vim config dir location for reuse later
local vim_home = os.getenv("VIM_HOME")
if vim_home then
  vim.g.vim_home = vim_home
else
  vim.g.vim_home = vim.fs.joinpath(os.getenv("HOME"), ".config/nvim/")
end

-- current vim session is over SSH
vim.g.ssh = not not os.getenv("SSH_CLIENT")
