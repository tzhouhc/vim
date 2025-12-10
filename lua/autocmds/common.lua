-- Autocommand Setup

local tooling = require("autocmds.tooling")
local ime = require("lib.ime")

-- on save, clean all trailing whitespaces.
tooling.create_toggleable_autocmd("auto_cleanup_whitespace", function()
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      vim.api.nvim_command(":FixWhitespace")
    end,
    group = vim.api.nvim_create_augroup("AutoFixWhitespace", { clear = true }),
  })
end, "AutoFixWhitespace")

-- on save, detect filetype if not set yet
tooling.create_toggleable_autocmd("detect_filetype_on_save", function()
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      if vim.bo.filetype == "" then
        vim.cmd(":filetype detect")
      end
    end,
    group = vim.api.nvim_create_augroup("AutoDetectFiletype", { clear = true }),
  })
end, "AutoDetectFiletype")

-- use EN IME on leaving Insert
tooling.create_toggleable_autocmd("auto_toggle_ime", ime.create_autocmds, ime.autogrp_name)

-- write oldfiles to disk before exiting vim
if vim.g.save_old_files then
  vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    callback = function()
      vim.cmd("redir >> /tmp/oldfiles.txt | silent oldfiles | redir end")
    end,
    group = vim.api.nvim_create_augroup("RecordOldFiles", { clear = true }),
  })
end
