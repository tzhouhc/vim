-- Telescope plugin configurations

local safe_require = require('lib.meta').safe_require

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
