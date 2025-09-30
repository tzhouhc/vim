local fzf_lua = require 'fzf-lua'
local git = require("lib.git")
local ft = require("lib.ft")
local edit = require("lib.editing")

local M = {}

-- Search across repo; if not repo, just under CWD
function M.local_or_repo_files()
  if git.is_git() then
    vim.cmd("FzfLua git_files")
    return
  end
  vim.cmd("FzfLua files")
end

function M.nerdfont()
  local csv_path = vim.fs.joinpath(os.getenv("HOME"), ".dotfiles/lib/nerdfont/nerdfont.csv")
  if not ft.is_file(csv_path) then
    vim.notify("Nerdfont data sheet not found.", vim.log.levels.ERROR, {})
  end
  fzf_lua.fzf_exec(function(fzf_cb)
      -- Read the contents of the nerdfont CSV file
      local f = io.open(csv_path, "r")
      if f then
        for line in f:lines() do
          fzf_cb(line)
        end
        f:close()
      else
        vim.notify("Failed to open nerdfont CSV file.", vim.log.levels.ERROR, {})
      end
      -- close pipe
      fzf_cb()
    end,
    {
      prompt = 'Nerdfont> ',
      exec_empty_query = true,
      actions = {
        ["default"] = function(selected)
          local res = string.gsub(selected[1], "^[^,]*,[^,]*,", "")
          edit.insert_after_cursor(res)
        end,
        ["ctrl-y"] = function(selected)
          local res = string.gsub(selected[1], "^[^,]*,[^,]*,", "")
          vim.fn.setreg('"', res)
        end
      }
    })
end

local function common_file_opts()
  local opts = {
    git_icons = true,
    file_icons = true,
    color_icons = true,
    actions = fzf_lua.defaults.actions.files,
    previewer = "builtin",
  }
  opts.fn_transform = function(x)
    return fzf_lua.make_entry.file(x, opts)
  end
  return opts
end

-- grep across repo
function M.live_grep_across_repo()
  if not git.is_git() then
    vim.cmd("FzfLua live_grep")
  end
  local opts = common_file_opts()
  opts.prompt = "rg> "
  opts.fn_preprocess = function(o)
    opts.diff_files = fzf_lua.make_entry.preprocess(o).diff_files
    return opts
  end
  return fzf_lua.fzf_live(function(q)
    return "rg --column --color=always -- " .. vim.fn.shellescape(q or '') .. " " .. git.soft_git_repo_root()
  end, opts)
end

-- This uses a custom git tool `git-dirt` from the dotfiles repo.
function M.changed_files_in_repo()
  if not git.is_git() then
    return fzf_lua.fzf_exec("ls")
  end
  local opts = common_file_opts()
  return fzf_lua.fzf_exec("git-rdirt", opts)
end

function M.all_files()
  local opts = common_file_opts()
  return fzf_lua.fzf_exec("fd . ~/ --hidden", opts)
end

function M.dotfiles()
  local opts = common_file_opts()
  return fzf_lua.fzf_exec(
    "git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME ls-files --full-name $HOME --format=\"$HOME/%(path)\"", opts)
end

-- Take current pasteboard, split by paragraph, and paste selected ones.
function M.current_pasteboard()
  -- Get the contents of the system pasteboard (register '+')
  local pbs = vim.fn.getreg('+')
  local pb
  if type(pbs) == 'string' then
    pb = vim.split(pbs, '\n\n', { plain = true })
  else
    return
  end

  -- Filter out empty entries
  local entries = {}
  for _, line in ipairs(pb) do
    if line ~= '' then
      table.insert(entries, line)
    end
  end
  if #entries == 0 then
    return
  end

  -- Use fzf-lua for multi-select
  return require('fzf-lua').fzf_exec(entries, {
    prompt = 'Pasteboard> ',
    actions = {
      ['default'] = function(selected)
        -- Join all selected entries with newlines and paste
        local text = table.concat(selected, '\n')
        vim.api.nvim_paste(text, true, -1)
      end,
    },
    fzf_opts = {
      ['--multi'] = true, -- allow selecting multiple lines
      ['--read0'] = true, -- allow entries with embedded newlines
    },
  })
end

function M.bcommit_change_base()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == "" then
    vim.notify("Buffer is not associated with a file.", vim.log.levels.ERROR)
    return
  end
  local cmd = string.format('git log --oneline -- %q', filepath)
  require('fzf-lua').fzf_exec(cmd, {
    prompt  = 'BCommits❯ ',
    preview = "git show --color {1} -- " .. filepath,
    actions = {
      ['default'] = function(selected)
        local hash = selected[1]:match('^%S+')
        if hash then
          vim.cmd('Gitsigns change_base ' .. hash)
        else
          vim.notify("Could not extract commit hash.", vim.log.levels.ERROR)
        end
      end,
    }
  })
end

return M
