local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local builtin = require "telescope.builtin"
local conf = require "telescope.config".values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

-- finds all standalone vim scripts in runtime path and source them.
function M.runtime_files(opts)
  local files = vim.api.nvim_get_runtime_file("*.vim", true)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Runtime Files",
    finder = finders.new_table {
      results = files,
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
    -- NOTE THE SPELLING: `attach_mappings`! Failure to pluralize causes the
    -- default mappings to be used and debugging to be hellish!
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()[1]
        vim.api.nvim_command("source "..selection)
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command('Runtimes', M.runtime_files, {})

function M.find_configs()
  builtin.find_files {
    prompt_title = " Neovim Configs",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.config/nvim",
    },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

vim.api.nvim_create_user_command('VimConfigs', M.find_configs, {})

function M.find_dotfiles()
  builtin.find_files {
    prompt_title = " Dotfiles",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.dotfiles",
    },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

vim.api.nvim_create_user_command('Dotfiles', M.find_dotfiles, {})

return M
