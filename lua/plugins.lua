-- Plugins Setups

---@diagnostic disable: missing-fields
local safe_require = require('lib.meta').safe_require

-- treesitter
safe_require 'nvim-treesitter.configs'.setup {
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
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]t"] = "@comment.outer",
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        -- ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[t"] = "@comment.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      }
    },
  },
}

safe_require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

-- telescope / fzf
safe_require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = safe_require("telescope.actions").close,
      },
    },
  },
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
safe_require('telescope').load_extension('fzf')
safe_require('telescope').load_extension('nerdy')

-- bufferline
safe_require("bufferline").setup {
  options = {
    show_buffer_close_icons = false,
  }
}

-- status lines
safe_require('lualine').setup({
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
safe_require('commander').setup({})
safe_require('commands')

-- gutentags
vim.g.gutentags_cache_dir                = os.getenv("HOME") .. "/.vim/tags"
-- custom tag file list using fd; see rest of dotfiles
vim.g.gutentags_file_list_command        = "gutentagger"
vim.g.gutentags_resolve_symlinks         = 1
vim.g.gutentags_define_advanced_commands = 1
