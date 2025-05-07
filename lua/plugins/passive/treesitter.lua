return {
  -- semantic parser
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        modules = { "highlight", "indent", "incremental_selection", "matchup" },
        -- A list of parser names, or "all"
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "go",
          "html",
          "java",
          "json",
          "just",
          "lua",
          "python",
          "regex",
          "ruby",
          "vim",
          "vimdoc",
          "yaml",
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
          -- disable = { "markdown", "text" },
          --
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            -- init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "<tab>",
            -- scope_incremental = "grc",
            node_decremental = "<s-tab>",
          },
        },
      })
    end,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" }
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = false,
            keymaps = {
              ["ac"] = "@comment.outer",
              ["ic"] = "@comment.inner",
              ["il"] = "@assignment.lhs",
              ["ir"] = "@assignment.rhs",
              ["al"] = "@assignment.lhs",
              ["ar"] = "@assignment.rhs",
            },
            selection_modes = {
              ["@comment.inner"] = "v",
              ["@comment.outer"] = "v",
              ["@assignment.lhs"] = "v",
              ["@assignment.rhs"] = "v",
            },
            include_surrounding_whitespace = false,
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-treehopper",
    dependencies = { "hadronized/hop.nvim" },
    keys = { "<c-h>", "g[", "g]" },
    config = function()
      require("hop").setup()
      local tsht = require("tsht")
      vim.keymap.set("n", "<c-h>", tsht.nodes)
      vim.keymap.set("n", "g[", function() tsht.move({ side = "start" }) end)
      vim.keymap.set("n", "g]", function() tsht.move({ side = "end" }) end)
    end
  }
}
