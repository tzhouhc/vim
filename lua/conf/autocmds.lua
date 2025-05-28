-- Autocommand Setup

local api = vim.api
local fn = vim.fn
local ime = require("lib.ime")
local nt = require("lib.notify")

local function cd()
  local path = fn.expand("%:h") .. "/"
  api.nvim_command("cd " .. path)
end

-- automatically update working dir when entering buffer.
api.nvim_create_augroup("WorkingDirectory", { clear = true })
api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.*" },
  callback = function()
    pcall(cd)
  end,
  group = "WorkingDirectory",
})

-- on save, clean all trailing whitespaces.
api.nvim_create_augroup("Misc", { clear = true })

if vim.g.auto_cleanup_whitespace then
  api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.*" },
    callback = function()
      api.nvim_command(":FixWhitespace")
    end,
    group = "Misc",
  })
end

-- exit ephemeral buffers with <esc>
api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = {
    "help",
    "noice",
    "checkhealth",
    "man",
  },
  callback = function()
    api.nvim_buf_set_keymap(api.nvim_get_current_buf(), "n", "<esc>", ":bd<cr>", { silent = true, noremap = true })
  end,
  group = "Misc",
})

-- visuals.lua get colorizer started automatically on file open
api.nvim_create_autocmd({ "BufRead" }, {
  pattern = {
    "visuals.lua", -- vim / wezterm visual configs
    "prompt.json", -- oh-my-posh prompt configs
    "rainbow.lua",
  },
  callback = function()
    vim.cmd("ColorizerToggle")
  end,
  group = "Misc",
})

-- write oldfiles to disk before exiting vim
if vim.g.save_old_files then
  api.nvim_create_autocmd({ "VimLeavePre" }, {
    pattern = { "*.*" },
    callback = function()
      vim.cmd("redir >> /tmp/oldfiles.txt | silent oldfiles | redir end")
    end,
    group = "Misc",
  })
end

-- use EN IME on leaving Insert
if vim.g.auto_toggle_ime then
  api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = { "*.*" },
    callback = ime.switch_to_en_ime,
    group = "Misc",
  })

  api.nvim_create_autocmd({ "InsertEnter" }, {
    pattern = { "*.*" },
    callback = function()
      if ime.context_is_cn() then
        ime.switch_to_cn_ime()
      end
    end,
    group = "Misc",
  })
end

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "sql",
  callback = function()
    vim.keymap.del('i', '<left>', { buffer = true })
    vim.keymap.del('i', '<right>', { buffer = true })
  end
})

api.nvim_create_augroup("Notification", { clear = true })

-- Visible notification for recording.
api.nvim_create_autocmd({ "RecordingEnter" }, {
  pattern = { "*.*" },
  callback = function()
    nt.notify_hover("Recording macro '" .. vim.fn.reg_recording() .. "'.")
  end,
  group = "Notification",
})

api.nvim_create_autocmd({ "RecordingLeave" }, {
  pattern = { "*.*" },
  callback = function()
    nt.notify_hover("Finished recording macro '" .. vim.fn.reg_recording() .. "'.")
  end,
  group = "Notification",
})

-- use help tags as if they are LSP symbols and jump using `g;`
local help_binds_grp = vim.api.nvim_create_augroup("HelpMappings", { clear = true })
local help_binds = {
  n = {
    ["gd"] = "<c-]>",
    ["g;"] = "<c-o>",
  }
}

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  group = help_binds_grp,
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.bo[bufnr].filetype
    if filetype == "help" then
      require("lib.misc").batch_set_buf_keymap(help_binds)
    end
  end
})
