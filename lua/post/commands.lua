-- Custom Commands
local scopes = require("lib.scopes")
local misc = require("lib.misc")
local terms = require("lib.terms")
local popups = require("lib.popups")
local ts = require("telescope")

-- Finding common files
vim.api.nvim_create_user_command("Runtimes", scopes.runtime_files, {})
vim.api.nvim_create_user_command("VimConfigs", scopes.find_configs, {})
vim.api.nvim_create_user_command("Dotfiles", scopes.find_dotfiles, {})
vim.api.nvim_create_user_command("Snippets", scopes.find_snippets, {})
vim.api.nvim_create_user_command("GrepAcrossRepo", scopes.live_grep_across_repo, {})
vim.api.nvim_create_user_command("FilesInRepo", scopes.files_in_repo, {})
vim.api.nvim_create_user_command("ChangedInRepo", scopes.changed_files_in_repo, {})

-- Telescope shortcuts
vim.api.nvim_create_user_command("Marks", require("telescope.builtin").marks, {})
vim.api.nvim_create_user_command("SelectSession", function()
  require("persistence").select()
end, {})
vim.api.nvim_create_user_command("SessionLoadLast", function()
  require("persistence").load({ last = true })
end, {})
vim.api.nvim_create_user_command("SessionLoadHere", function()
  require("persistence").load()
end, {})

-- Tooling shortcuts
vim.api.nvim_create_user_command("GetPluginLink", misc.get_current_line_plugin, {})
vim.api.nvim_create_user_command("FormatCode", function()
  vim.lsp.buf.format({ async = true })
end, {})

-- Popup terminals
vim.api.nvim_create_user_command("Git", terms.lazy_git, {})
vim.api.nvim_create_user_command("FloatRight", terms.right_side_term, {})
vim.api.nvim_create_user_command("H", popups.help_popup, { nargs = "?", complete = "help" })

-- Telescope
local repo_ignore = {
  file_ignore_patterns = {
    "%.Trash/",
    "%.local/",
    "%.cache/",
    "%.zgen/",
    "%.cargo/",
    "nvim/lazy",
  },
}
vim.api.nvim_create_user_command("SelectFromRepositories", function() ts.extensions.repo.cached_list(repo_ignore) end, {})
