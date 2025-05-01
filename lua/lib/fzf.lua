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
  if not misc.is_git() then
    vim.cmd("FzfLua live_grep")
  end
  local opts = {}
  opts.prompt = "rg> "
  opts.git_icons = true
  opts.file_icons = true
  opts.color_icons = true
  opts.actions = fzf_lua.defaults.actions.files
  opts.previewer = "builtin"
  opts.fn_transform = function(x)
    return fzf_lua.make_entry.file(x, opts)
  end
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
  if not misc.is_git() then
    return fzf_lua.fzf_exec("ls")
  end
  local opts = {}
  opts.git_icons = true
  opts.file_icons = true
  opts.color_icons = true
  opts.actions = fzf_lua.defaults.actions.files
  opts.previewer = "builtin"
  opts.fn_transform = function(x)
    return fzf_lua.make_entry.file(x, opts)
  end
  return fzf_lua.fzf_exec("git-rdirt", opts)
end

function M.all_files()
  local opts = {}
  opts.git_icons = true
  opts.file_icons = true
  opts.color_icons = true
  opts.actions = fzf_lua.defaults.actions.files
  opts.previewer = "builtin"
  opts.fn_transform = function(x)
    return fzf_lua.make_entry.file(x, opts)
  end
  return fzf_lua.fzf_exec("fd . \"/Applications/\" --extension app & fd . ~/ --hidden", opts)
end

return M
