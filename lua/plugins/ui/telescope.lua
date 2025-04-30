return {
  -- tool for searching stuff
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      local ts = require("telescope")

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
        defaults = {
          mappings = default_mapping,
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor {
              -- even more opts
            }
          },
          undo = {},
        }
      })
      ts.load_extension("ui-select")
      ts.load_extension("undo")

      local scopes = require("lib.scopes")
			-- key binds
      local key_configs = {
        n = {
          -- files in the entire repo
          ["<m-o>"] = scopes.local_or_repo_files,
          -- files in the repo that have changed
          ["<m-p>"] = scopes.changed_files_in_repo,
          -- undo tree
          ["<leader>ud"] = ":Telescope undo<cr>",
        },
      }
    end

  },
  { "nvim-telescope/telescope-ui-select.nvim" },
}
