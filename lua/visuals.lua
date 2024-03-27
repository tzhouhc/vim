vim.cmd("colorscheme nord")

-- other options
vim.opt.conceallevel=2
vim.opt.concealcursor="nc"
vim.opt.foldlevelstart=99
vim.opt.colorcolumn="80"

-- italics
vim.cmd("highlight Special gui=italic")
vim.cmd("highlight Comment gui=italic")
vim.cmd("highlight Italic gui=italic")
vim.cmd("highlight Bold gui=bold")
vim.cmd("highlight mkdBold gui=bold")
vim.cmd("highlight htmlItalic gui=italic")

-- signify
vim.cmd("highlight SignifySignAdd guifg=#2dd671")
vim.cmd("highlight SignifySignDelete guifg=#d94a0d")
vim.cmd("highlight SignifySignChange guifg=#e6bf12")

-- quickscope
vim.cmd("highlight QuickScopePrimary guifg=#71eb34 gui=underline")
vim.cmd("highlight QuickScopeSecondary guifg=#348feb gui=bold")

if vim.api.nvim_win_get_option(0, "diff") then
  vim.opt.diffopt="filler,context:1000000"
end
