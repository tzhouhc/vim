require("scrollbar").setup()
require("ibl").setup()
require("gitsigns").setup()
require("Comment").setup()
require("which-key").setup()
require('twilight').setup()
require('nvim-autopairs').setup()
require("nvim-surround").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("neodev").setup()

-- fzf
require("fzf-lua").setup({ "fzf-vim" })

-- bufferline
require("bufferline").setup{
  options = {
    show_buffer_close_icons = false,
  }
}

-- status lines
require('lualine').setup({
  options = { theme = 'nord' }
})

-- signify
vim.g.signify_sign_change = '~'

-- noice
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
