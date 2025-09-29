return {
  -- tool for searching or selecting stuff
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      local actions = require("fzf-lua").actions
      local fv = require("lib.plugin.fzflua")
      fzf.setup({
        actions = {
          files = {
            ["enter"] = actions.file_edit,
          },
        },
        previewers = {
          builtin = {
            ueberzug_scaler = false,
            snacks_image    = { enabled = false },
            extensions      = {
              ["png"] = { "imgcatr" },
              ["jpg"] = { "imgcatr" },
              ["jpeg"] = { "imgcatr" },
            },
          }
        },
      })
      fzf.register_ui_select()

      -- keymaps
      local key_configs = {
        n = {

          -- f: search for text content
          -- o: open file
          -- p: special open file

          -- CTRL group, doesn't have special meaning, can be used in general cases.
          -- local files
          ["<c-o>"] = ":FzfLua files<cr>",
          -- lines in current buffer
          ["<c-f>"] = ":FzfLua blines<cr>",
          -- recent files
          ["<c-p>"] = ":FzfLua oldfiles<cr>",
          -- tags
          ["<c-k>"] = ":FzfLua btags<cr>",

          -- META group, for git repo or such actions. Have fallback behavior
          -- if incorrectly invoked.
          -- lines across the repo
          -- ["<m-f>"] = fv.live_fuzzy_grep_across_repo,
          -- files in the entire repo
          ["<m-o>"] = fv.local_or_repo_files,
          -- files in the repo that have changed
          ["<m-p>"] = fv.changed_files_in_repo,
          -- local symbols based on LSP symbols
          ["<m-k>"] = ":FzfLua lsp_document_symbols<cr>",

          -- registers
          ["<leader>p"] = ":FzfLua registers<cr>",
        },
        v = {
          -- search for visually selected
          ["<c-f>"] = ":FzfLua grep_visual<cr>",

          ["<leader>p"] = ":FzfLua registers<cr>",
        }
      }
      require("lib.binder").batch_set_keymap(key_configs)

      -- commands
      vim.api.nvim_create_user_command("Registers", "FzfLua registers", {})
      vim.api.nvim_create_user_command("Highlights", "FzfLua highlights", {})
      vim.api.nvim_create_user_command("Manpages", "FzfLua manpages", {})
      vim.api.nvim_create_user_command("HelpTags", "FzfLua helptags", {})
      vim.api.nvim_create_user_command("FilesInRepo", "FzfLua git_files", {})
      vim.api.nvim_create_user_command("GitFileHistory", "FzfLua git_bcommits", {})
      vim.api.nvim_create_user_command("ChangedInRepo", "FzfLua git_diffs", {})
      vim.api.nvim_create_user_command("Changes", "FzfLua git_hunks", {})
      vim.api.nvim_create_user_command("Zoxide", "FzfLua zoxide", {})
      vim.api.nvim_create_user_command("Diagnostics", "FzfLua lsp_document_diagnostics", {})
      vim.api.nvim_create_user_command("Z", "FzfLua zoxide", {})
      vim.api.nvim_create_user_command("Symbols", "FzfLua lsp_document_symbols", {})
      vim.api.nvim_create_user_command("WorkspaceSymbols", "FzfLua lsp_workspace_symbols", {})
      vim.api.nvim_create_user_command("Callsites", "FzfLua lsp_incoming_calls", {})
      vim.api.nvim_create_user_command("Invokes", "FzfLua lsp_outgoing_calls", {})

      -- custom scopes
      vim.api.nvim_create_user_command("GrepAcrossRepo", fv.live_grep_across_repo, {})
      vim.api.nvim_create_user_command("AllFiles", fv.all_files, {})
      vim.api.nvim_create_user_command("Nerdfont", fv.nerdfont, {})
      vim.api.nvim_create_user_command("Pasteboard", fv.current_pasteboard, {})
      vim.api.nvim_create_user_command("RebaseGitsigns", fv.bcommit_change_base, {})

      -- aliases
      vim.api.nvim_create_user_command("Snippets", "FzfLua files cwd=~/.config/nvim/snippets", {})
      vim.api.nvim_create_user_command("Dotfiles", fv.dotfiles, {})
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    cmd = { "Telescope" },
    keys = { { "<leader>ud", mode = "n" } },
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
      })
      ts.load_extension("undo")
      local key_configs = {
        n = {
          -- undo tree
          ["<leader>ud"] = ":Telescope undo<cr>",
        },
      }
      require("lib.binder").batch_set_keymap(key_configs)
    end

  },
}
