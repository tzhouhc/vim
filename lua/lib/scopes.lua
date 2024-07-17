local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local builtin = require("telescope.builtin")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local misc = require("lib.misc")

local M = {}

-- finds all standalone vim scripts in runtime path and source them.
function M.runtime_files(opts)
  local files = vim.api.nvim_get_runtime_file("*.vim", true)
  opts = opts or {}
  pickers
      .new(opts, {
        prompt_title = " Runtime Files",
        finder = finders.new_table({
          results = files,
        }),
        sorter = conf.file_sorter(opts),
        previewer = conf.file_previewer(opts),
        -- NOTE THE SPELLING: `attach_mappings`! Failure to pluralize causes the
        -- default mappings to be used and debugging to be hellish!
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()[1]
            vim.api.nvim_command("source " .. selection)
          end)
          return true
        end,
      })
      :find()
end

function M.find_configs()
  builtin.find_files({
    prompt_title = " Neovim Configs",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.config/nvim",
    },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.find_dotfiles()
  builtin.find_files({
    prompt_title = " Dotfiles",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.dotfiles",
    },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.find_snippets()
  builtin.find_files({
    prompt_title = " Snippets",
    results_title = "Snippet Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.config/nvim/snippets",
    },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.live_grep_across_repo()
  builtin.live_grep({
    prompt_title = "󰊢 Searching Across Repository",
    search_dirs = { misc.git_repo_root() },
  })
end

function M.files_in_repo()
  builtin.find_files({
    prompt_title = "󰊢 Files in Repository",
    search_dirs = { misc.git_repo_root() },
  })
end

-- This uses a custom git tool `git-dirt` from the dotfiles repo.
function M.changed_files_in_repo()
  builtin.find_files({
    prompt_title = "󰊢 Changed Files in Repository",
    find_command = {"git-dirt",},
    search_dirs = { misc.git_repo_root() },
  })
end

return M
