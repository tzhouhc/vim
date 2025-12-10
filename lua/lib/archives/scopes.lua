-- Deprecated in favor of FzfLua

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local builtin = require("telescope.builtin")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local git = require("lib.git")

local M = {}

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

function M.open_file_history_selector(opts)
  -- Get current file path
  local current_file = vim.fn.expand("%:p")

  if opts and opts.branch then
    -- First, select a branch using Telescope
    require("telescope.builtin").git_branches({
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          -- Get selected branch
          local branch_selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
          require("telescope.actions").close(prompt_bufnr)

          if branch_selection then
            local branch_name = branch_selection.name or branch_selection.value

            -- Now, show commits from the selected branch
            require("telescope.builtin").git_commits({
              -- Specify the branch to get commits from
              git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", branch_name },

              attach_mappings = function(_, inner_map)
                inner_map("i", "<CR>", function(inner_prompt_bufnr)
                  -- Get selected commit
                  local commit_selection = require("telescope.actions.state").get_selected_entry(inner_prompt_bufnr)
                  require("telescope.actions").close(inner_prompt_bufnr)

                  if commit_selection and commit_selection.value then
                    -- Open diffview with the selected commit
                    vim.cmd(
                      string.format(
                        "DiffviewOpen %s --selected-file=%s -- %s",
                        commit_selection.value,
                        current_file,
                        current_file
                      )
                    )
                  end

                  return true
                end)
                return true
              end,
            })
          end

          return true
        end)
        return true
      end,
    })
  else
    -- Simple commit picker from current branch
    require("telescope.builtin").git_commits({
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          -- Get selected commit
          local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
          require("telescope.actions").close(prompt_bufnr)

          if selection and selection.value then
            -- Open diffview with the selected commit
            vim.cmd(
              string.format("DiffviewOpen %s --selected-file=%s -- %s", selection.value, current_file, current_file)
            )
          end

          return true
        end)
        return true
      end,
    })
  end
end

function M.local_or_repo_files()
  if git.is_git() then
    vim.cmd("FilesInRepo")
    return
  end
  vim.cmd("Telescope find_files")
end

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
    search_dirs = { git.git_repo_root() },
  })
end

function M.files_in_repo()
  builtin.find_files({
    prompt_title = "󰊢 Files in Repository",
    search_dirs = { git.git_repo_root() },
  })
end

-- This uses a custom git tool `git-dirt` from the dotfiles repo.
function M.changed_files_in_repo()
  builtin.find_files({
    prompt_title = "󰊢 Changed Files in Repository",
    find_command = { "git-dirt" },
    search_dirs = { git.git_repo_root() },
  })
end

return M
