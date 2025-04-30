local fzf_lua = require 'fzf-lua'
local misc = require("lib.misc")

local M = {}

-- Search across repo; if not repo, just under CWD
function M.local_or_repo_files()
  if misc.is_git() then
    vim.cmd("FzfLua git_files")
    return
  end
  vim.cmd("FzfLua files")
end

-- grep across repo
function M.live_grep_across_repo()
  -- builtin.live_grep({
  --   prompt_title = "󰊢 Searching Across Repository",
  --   search_dirs = { misc.git_repo_root() },
  -- })
  local opts = {}
  opts.prompt = "rg> "
  opts.git_icons = true
  opts.file_icons = true
  opts.color_icons = true
  -- setup default actions for edit, quickfix, etc
  opts.actions = fzf_lua.defaults.actions.files
  -- see preview overview for more info on previewers
  opts.previewer = "builtin"
  opts.fn_transform = function(x)
    return fzf_lua.make_entry.file(x, opts)
  end
  -- we only need 'fn_preprocess' in order to display 'git_icons'
  -- it runs once before the actual command to get modified files
  -- 'make_entry.file' uses 'opts.diff_files' to detect modified files
  -- will probaly make this more straight forward in the future
  opts.fn_preprocess = function(o)
    opts.diff_files = fzf_lua.make_entry.preprocess(o).diff_files
    return opts
  end
  return fzf_lua.fzf_live(function(q)
    return "rg --column --color=always -- " .. vim.fn.shellescape(q or '') .. " " .. misc.git_repo_root()
  end, opts)
end

-- This uses a custom git tool `git-dirt` from the dotfiles repo.
function M.changed_files_in_repo()
  -- builtin.find_files({
  --   prompt_title = "󰊢 Changed Files in Repository",
  --   find_command = { "git-dirt", },
  --   search_dirs = { misc.git_repo_root() },
  -- })
  local opts = {}
  opts.git_icons = true
  opts.file_icons = true
  opts.color_icons = true
  -- setup default actions for edit, quickfix, etc
  opts.actions = fzf_lua.defaults.actions.files
  -- see preview overview for more info on previewers
  opts.previewer = "builtin"
  opts.fn_transform = function(x)
    return fzf_lua.make_entry.file(x, opts)
  end
  return fzf_lua.fzf_exec("git-rdirt", opts)
end

return M
