-- Autocommand Setup

local ime = require("lib.ime")

-- on save, clean all trailing whitespaces.
if vim.g.auto_cleanup_whitespace then
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      vim.api.nvim_command(":FixWhitespace")
    end,
    group = vim.api.nvim_create_augroup("AutoFixWhitespace", { clear = true }),
  })
end

-- on save, detect filetype if not set yet
if vim.g.detect_filetype_on_save then
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      if vim.bo.filetype == "" then
        vim.cmd(":filetype detect")
      end
    end,
    group = vim.api.nvim_create_augroup("AutoDetectFiletype", { clear = true }),
  })
end

-- write oldfiles to disk before exiting vim
if vim.g.save_old_files then
  vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    callback = function()
      vim.cmd("redir >> /tmp/oldfiles.txt | silent oldfiles | redir end")
    end,
    group = vim.api.nvim_create_augroup("RecordOldFiles", { clear = true }),
  })
end

-- use EN IME on leaving Insert
if vim.g.auto_toggle_ime then
  ime.create_autocmds()
end

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "sql",
  callback = function()
    vim.keymap.del('i', '<left>', { buffer = true })
    vim.keymap.del('i', '<right>', { buffer = true })
  end,
  group = vim.api.nvim_create_augroup("RemoveSqlKeymapQuirk", { clear = true }),
})

-- use help tags as if they are LSP symbols and jump using `g;`
local help_binds = {
  n = {
    ["gd"] = "<c-]>",
    ["g;"] = "<c-o>",
  }
}

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  group = vim.api.nvim_create_augroup("HelpMappings", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.bo[bufnr].filetype
    if filetype == "help" then
      require("lib.binder").batch_set_buf_keymap(help_binds)
    end
  end
})
