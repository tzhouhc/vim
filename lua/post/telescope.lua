-- Telescope plugin configurations

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
require("telescope").load_extension("nerdy")

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
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
        ["<esc>"] = require("telescope.actions").close,
      }
    }
  }
}

local easypick = require("easypick")
local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
local base_branch = vim.fn.system(get_default_branch) or "main"

easypick.setup({
  pickers = {
    -- diff current branch with base_branch and show files that changed with respective diffs in preview
    {
      name = "changed_files",
      command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
      previewer = easypick.previewers.branch_diff({ base_branch = base_branch })
    },
  }
})
