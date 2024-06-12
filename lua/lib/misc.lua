local M = {}

local function extract_plugin(line)
	-- first string literal in the line
	return line:match("[\"']([^'\"]+)[\"']")
end

function M.dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

---Setup autocmd to close a window on cursor move. Suitable for use with
---nvim.notify.
---@param win integer
function M.window_auto_close(win)
	vim.api.nvim_create_autocmd({ "CursorMoved" }, {
		callback = function()
      vim.api.nvim_win_close(win, true)
		end,
		once = true,
	})
end

function M.popup(content)
	require("noice").notify(content, "󰍡")
end

function M.noice_hover(content)
	require("noice").redirect(function()
		print(content) -- always a msg_show event
	end, {
		{
			view = "timid_hover",
			filter = { event = "msg_show" },
		},
	})
end

function M.notify_hover(content)
  require("notify").notify(content, "info", {
    on_open = M.window_auto_close
  })
end

---look for patterns matching a GitHub repo and open it in the browser.
function M.get_current_line_plugin()
	local line = vim.api.nvim_get_current_line()
	local plugin = extract_plugin(line)
	if vim.fn.has("macunix") then
		-- directly shell out and open the plugin github page
		vim.fn.system("open 'https://github.com/" .. plugin .. "'")
	else
		-- create popup with the link so user can do whatever
		M.popup("https://github.com/" .. plugin)
	end
end

---check for windows with specific key properties, e.g. "quickfix"
---@param type string
---@return boolean
function M.has_win_of_type(type)
	local windows = vim.fn.getwininfo()
	for _, win in pairs(windows) do
		if win[type] == 1 then
			return true
		end
	end
	return false
end

---check whether current file is under a git repo
---@return boolean
function M.is_git()
  -- remember: system calls return include a newline character
  local git = vim.fn.system("git rev-parse --is-inside-work-tree")
  return git:match("true") == "true"
end

return M
