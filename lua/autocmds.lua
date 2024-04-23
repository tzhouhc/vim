-- Autocommand Setup

local api = vim.api
local fn = vim.fn

local function cd()
  local path = fn.expand('%:h') .. '/'
  api.nvim_command("cd " .. path)
end

-- automatically update working dir when entering buffer.
-- this helps with telescope and live_grep determining the cwd.
--
-- vim.o.autochdir doesn't work nicely with telescope for some reason.
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
api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { "*.*" },
  callback = function()
    api.nvim_command(":FixWhitespace")
  end,
  group = "Misc"
})

-- exit ephemeral buffers with <esc>
api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = {
    "help",
    "noice",
    "Trouble",
    "checkhealth",
    "man",
  },
  callback = function()
    api.nvim_buf_set_keymap(api.nvim_get_current_buf(),
      'n', '<esc>', ':bd<cr>', { silent = true, noremap = true }
    )
  end,
  group = "Misc"
})
