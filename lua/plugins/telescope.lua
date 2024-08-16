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
    config = function()
      local ts = require("telescope")
      ts.load_extension("fzf")
      ts.load_extension("repo")

      local select_one_or_multi = function(prompt_bufnr)
        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          require('telescope.actions').close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then
              vim.cmd(string.format('%s %s', 'edit', j.path))
            end
          end
        else
          require('telescope.actions').select_default(prompt_bufnr)
        end
      end

      -- make it so telescope multiple-select in file-selection actually works
      -- as imagined.
      local default_mapping = {
        i = {
          ['<CR>'] = select_one_or_multi,
          ["<esc>"] = require("telescope.actions").close,
        }
      }
      ts.setup({
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
        defaults = {
          mappings = default_mapping,
        },
      })
    end
  },
  -- },
  -- with fzf
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "cljoly/telescope-repo.nvim" },
}
