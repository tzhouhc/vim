return {
  -- tool for searching stuff
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
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
          }
        }
      })
      ts.load_extension("ui-select")

      local scopes = require("lib.scopes")
			-- key binds
      local key_configs = {
        n = {
          -- local files
          ["<c-o>"] = ":Telescope find_files<cr>",
          -- files in the entire repo
          ["<m-o>"] = scopes.local_or_repo_files,
          -- files in the repo that have changed
          ["<m-p>"] = scopes.changed_files_in_repo,
          -- lines in current buffer
          ["<c-f>"] = ":Telescope current_buffer_fuzzy_find<cr>",
          -- lines across the repo
          ["<m-f>"] = scopes.live_grep_across_repo,
          -- lines in all local dir files
          ["<c-g>"] = ":Telescope live_grep<cr>",
          -- local symbols based on treesitter
          ["<c-k>"] = ":Telescope treesitter<cr>",
          -- local symbols based on LSP symbols
          ["<m-k>"] = ":Telescope lsp_document_symbols<cr>",
          -- git changes
          ["<c-p>"] = ":Telescope oldfiles<cr>",
					-- use telescopes for registers invocation instead
					["<leader>p"] = ":Telescope registers<cr>",
        },
				v = {
					["<leader>p"] = ":Telescope registers<cr>",
				}
      }
			-- commands
			local tsb = require("telescope.builtin")
			vim.api.nvim_create_user_command("Symbols", tsb.lsp_document_symbols, {})
			vim.api.nvim_create_user_command("WorkspaceSymbols", tsb.lsp_workspace_symbols, {})
			vim.api.nvim_create_user_command("Registers", tsb.registers, {})
			vim.api.nvim_create_user_command("Highlights", tsb.highlights, {})
			vim.api.nvim_create_user_command("Manpages", tsb.man_pages, {})

      require("lib.misc").batch_set_keymap(key_configs)
    end

  },
  { "nvim-telescope/telescope-ui-select.nvim" },
}
