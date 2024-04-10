local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config".values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local runtime_files = function(opts)
  local files = vim.api.nvim_get_runtime_file("*.vim", true)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Runtime Files",
    finder = finders.new_table {
      results = files,
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
    -- why does this NOT WORK?
    attach_mapping = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection[1] }, "", false, true)
        -- vim.api.nvim_command("source "..selection)
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command('Runtimes', runtime_files, {})
