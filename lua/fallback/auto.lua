-- Autocommand Setup

local api = vim.api
local fn = vim.fn

local function cd()
	local path = fn.expand("%:h") .. "/"
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

-- autocmd BufWritePost * FixWhitespace
api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.*" },
	callback = function()
		api.nvim_command(":FixWhitespace")
	end,
})
