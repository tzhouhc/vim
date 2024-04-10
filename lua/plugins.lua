---@diagnostic disable: missing-fields

-- treesitter
require 'nvim-treesitter.configs'.setup {
  modules = { "highlight" },
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "go",
    "python",
    "lua",
    "ruby",
    "c",
    "vim",
    "vimdoc",
    "cpp",
    "bash",
    "yaml",
    "json",
    "java",
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  -- List of parsers to ignore installing (or "all")
  ignore_install = {},
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = { 'markdown', 'text' },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

-- telescope / fzf
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('nerdy')
-- custom telescopes
require("scopes")


-- bufferline
require("bufferline").setup {
  options = {
    show_buffer_close_icons = false,
  }
}

-- status lines
require('lualine').setup({
  options = { theme = 'nord' }
})

-- signify
vim.g.signify_sign_change = '┃'
vim.g.signify_sign_add = '┃'
vim.g.signify_sign_delete_first_line = '▔'
vim.g.signify_sign_delete_change = '┃'
vim.g.signify_sign_delete_change_delete = '┣'
vim.g.signify_vcs_cmds = {
  perforce = 'env DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]',
  git = 'git diff --no-color --no-ext-diff -U0 -- %f',
  hg = 'hg diff --color=never --config aliases.diff= --nodates -U0 -- %f'
}

-- changes
vim.g.changes_add_sign = '┃'
vim.g.changes_delete_sign = '┃'
vim.g.changes_modified_sign = '┃'

-- commander
require('commander').setup({})
require('commands')
