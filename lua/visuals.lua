-- theme
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

-- scrollbar
require("scrollbar").setup()

-- lightline
vim.cmd("source $HOME/.vim/configs/lightline.vim")

-- rainbow delimiters
vim.cmd("highlight RainbowDelim0 guifg=#F6ED56")
vim.cmd("highlight RainbowDelim1 guifg=#A6C955")
vim.cmd("highlight RainbowDelim2 guifg=#4BA690")
vim.cmd("highlight RainbowDelim3 guifg=#4191C9")
vim.cmd("highlight RainbowDelim4 guifg=#2258A0")
vim.cmd("highlight RainbowDelim5 guifg=#654997")
vim.cmd("highlight RainbowDelim6 guifg=#994D95")
vim.cmd("highlight RainbowDelim7 guifg=#D45196")
vim.cmd("highlight RainbowDelim8 guifg=#DB3A35")
vim.cmd("highlight RainbowDelim9 guifg=#E5783A")
vim.cmd("highlight RainbowDelim10 guifg=#EC943F")
vim.cmd("highlight RainbowDelim11 guifg=#F7C247")

require('rainbow-delimiters.setup').setup {
  highlight = {
    'RainbowDelim0',
    'RainbowDelim1',
    'RainbowDelim2',
    'RainbowDelim3',
    'RainbowDelim4',
    'RainbowDelim5',
    'RainbowDelim6',
    'RainbowDelim7',
    'RainbowDelim8',
    'RainbowDelim9',
    'RainbowDelim10',
    'RainbowDelim11',
  }
}

-- colorizer
require('colorizer').setup()
