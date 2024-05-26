require("nvim-devdocs").setup{
  wrap = true,
  previewer_cmd = "bat",
  cmd_args = {"-p"},
  picker_cmd = "bat",
  picker_cmd_args = {"-p"},
  after_open = function(_)
    vim.cmd('set statuscolumn=')
    vim.cmd('set ft=markdown')
  end
}
