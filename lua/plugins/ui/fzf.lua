return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      local actions = require("fzf-lua").actions
      local fv = require("lib.fzf")
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
          ["<m-f>"] = fv.live_grep_across_repo,
          -- files in the entire repo
          ["<m-o>"] = fv.local_or_repo_files,
          -- files in the repo that have changed
          ["<m-p>"] = fv.changed_files_in_repo,
          -- local symbols based on LSP symbols
          ["<m-k>"] = ":FzfLua lsp_document_symbols<cr>",

          -- registers
          ["<leader>p"] = ":FzfLua registers<cr>",
          ["<leader>sb"] = ":FzfLua lsp_document_symbols<cr>",
        },
        v = {
          -- search for visually selected
          ["<c-f>"] = ":FzfLua grep_visual<cr>",

          ["<leader>p"] = ":FzfLua registers<cr>",
        }
      }
      require("lib.misc").batch_set_keymap(key_configs)

      -- commands
      vim.api.nvim_create_user_command("Registers", "FzfLua registers", {})
      vim.api.nvim_create_user_command("Highlights", "FzfLua highlights", {})
      vim.api.nvim_create_user_command("Manpages", "FzfLua manpages", {})
      vim.api.nvim_create_user_command("HelpTags", "FzfLua helptags", {})
      vim.api.nvim_create_user_command("FilesInRepo", "FzfLua git_files", {})
      vim.api.nvim_create_user_command("Zoxide", "FzfLua zoxide", {})
      vim.api.nvim_create_user_command("Z", "FzfLua zoxide", {})

      -- custom scopes
      vim.api.nvim_create_user_command("GrepAcrossRepo", fv.live_grep_across_repo, {})
      vim.api.nvim_create_user_command("ChangedInRepo", fv.changed_files_in_repo, {})
      vim.api.nvim_create_user_command("AllFiles", fv.all_files, {})

      -- aliases
      vim.api.nvim_create_user_command("Snippets", "FzfLua files cwd=~/.config/nvim/snippets", {})
    end
  }
}
