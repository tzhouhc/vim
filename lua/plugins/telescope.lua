return {
  -- tool for searching stuff
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    lazy = true,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },
  },
  -- with fzf
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "cljoly/telescope-repo.nvim" },
}
