-- Autocommand Setup

local ime = require("lib.ime")

local function cd()
  local path = vim.fn.expand("%:h") .. "/"
  vim.api.nvim_command("cd " .. path)
end

-- automatically update working dir when entering buffer.
vim.api.nvim_create_augroup("WorkingDirectory", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    pcall(cd)
  end,
  group = "WorkingDirectory",
})

-- on save, clean all trailing whitespaces.
vim.api.nvim_create_augroup("Misc", { clear = true })

if vim.g.auto_cleanup_whitespace then
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      vim.api.nvim_command(":FixWhitespace")
    end,
    group = "Misc",
  })
end

-- exit ephemeral buffers with <esc>
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = {
    "help",
    "noice",
    "checkhealth",
    "man",
  },
  callback = function()
    vim.api.nvim_buf_set_keymap(vim.api.nvim_get_current_buf(), "n", "<esc>", ":bd<cr>", { silent = true, noremap = true })
  end,
  group = "Misc",
})

-- write oldfiles to disk before exiting vim
if vim.g.save_old_files then
  vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    callback = function()
      vim.cmd("redir >> /tmp/oldfiles.txt | silent oldfiles | redir end")
    end,
    group = "Misc",
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
  end
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
      require("lib.binder").batch_set_buf_keymap(help_binds)
    end
  end
})
