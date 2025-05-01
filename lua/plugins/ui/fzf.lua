return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      local fv = require("lib.fzf")
      fzf.setup({
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
          -- local files
          ["<c-o>"] = ":FzfLua files<cr>",
          -- lines in current buffer
          ["<c-f>"] = ":FzfLua blines<cr>",
          -- lines across the repo
          ["<m-f>"] = fv.live_grep_across_repo,
          -- local symbols based on treesitter
          ["<c-k>"] = ":FzfLua treesitter<cr>",
          -- files in the entire repo
          ["<m-o>"] = fv.local_or_repo_files,
          -- files in the repo that have changed
          ["<m-p>"] = fv.changed_files_in_repo,
          -- local symbols based on LSP symbols
          ["<m-k>"] = ":FzfLua lsp_document_symbols<cr>",
          -- git changes
          ["<c-p>"] = ":FzfLua oldfiles<cr>",
          -- registers
          ["<leader>p"] = ":FzfLua registers<cr>",
        },
        v = {
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
