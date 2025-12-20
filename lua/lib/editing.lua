-- Utilities that deal with neovim text editing space -- lines, visuals, cursor
-- positions, etc.

local M = {}

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)

function M.return_to_normal_mode()
  vim.api.nvim_feedkeys(esc, "n", false)
end

-- WARN: doesn't quite work well enough if line doesn't contain comment or TS
-- doesn't recognize comments for current context
function M.go_to_start_of_comment()
  -- this _does_ require remapping from tree-sitter's text object seeking.
  -- we go to end of line the seek backwards since we want to avoid the
  -- situation where we are already at a comment.outer and `]c` jumps to the
  -- *next* one after that.
  --
  -- Note that if called on a line without a comment it will jump way out.
  vim.api.nvim_feedkeys("$[tf l", "M", false)
end

-- Return the word under the cursor.
function M.get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

local alternating_zero_behaviors = {
  function()
    vim.api.nvim_feedkeys("0", "n", false)
  end,
  function()
    vim.api.nvim_feedkeys("^", "n", false)
  end,
  function()
    vim.api.nvim_feedkeys("f l", "n", false)
  end,
}

-- Alternate the cursor position between three states:
-- start of line, start of non-spaces, first after comment.
function M.alternating_zero()
  -- we maintain the same start for each distinct row we run this in
  local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
  -- initialize global var for alternating if we are starting out fresh
  -- OR if we just moved to a new row
  if vim.g.alternating_zero_state == nil or row ~= vim.g.alternating_zero_row then
    vim.g.alternating_zero_row = row
    vim.g.alternating_zero_state = 1
  end

  alternating_zero_behaviors[vim.g.alternating_zero_state]()
  vim.g.alternating_zero_state = vim.g.alternating_zero_state + 1
  if vim.g.alternating_zero_state > 3 then
    vim.g.alternating_zero_state = 1
  end
end

-- Shift-I based somewhat on line content
function M.smarter_shift_i()
  local syns = vim.inspect_pos() -- assume default: current buffer, on cursor
  for _, syn in ipairs(syns["treesitter"]) do
    if syn["capture"] == "comment" then
      M.go_to_start_of_comment()
      vim.api.nvim_feedkeys("i", "n", false)
      return
    end
  end
  vim.api.nvim_feedkeys("I", "n", false)
end

function M.smart_move_to_start_and_insert()
  M.smart_move_to_start()
  vim.cmd.startinsert()
end

-- Add a blank line after cursor line without moving cursor
function M.add_blank_line_after()
  local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row, row, false, { "" })
end

-- Add a blank line before cursor line without moving cursor
function M.add_blank_line_before()
  local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "" })
end

-- Invoke or close the quickfix window.
function M.toggle_quickfix()
  if require("lib.windows").has_win_of_type("quickfix") then
    vim.cmd.cclose()
    return
  end
  vim.cmd.copen()
end

local function last_non_empty_line(row)
  if row == nil then
    row = vim.api.nvim_win_get_cursor(0)[1] - 1
  end
  local content = ""
  repeat
    content = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    row = row - 1
  until content ~= "" or row == 0
  return content
end

---get the character under the cursor with the given offset
---@param offset integer
---@param lookback boolean
function M.get_char_at_cursor(offset, lookback)
  if offset == nil then
    offset = 0
  end
  if lookback == nil then
    lookback = false
  end
  local line = vim.api.nvim_get_current_line()
  local pos = vim.api.nvim_win_get_cursor(0)[2] + offset + 1
  if pos <= 0 then
    if lookback then
      local line = last_non_empty_line()
      if line ~= nil then
        return line:sub(#line, #line)
      end
    else
      pos = 0
    end
  end
  return line:sub(pos, pos)
end

function M.insert_after_cursor(str)
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local before = line:sub(1, col)
  local after = line:sub(col + 1)
  local new_line = before .. str .. after
  vim.api.nvim_set_current_line(new_line)
end

-- Get the start and end lines of visual selection
function M.get_visual_selection_lines()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- start_pos[2] and end_pos[2] contain the line numbers
  local start_line = start_pos[2]
  local end_line = end_pos[2]

  return start_line, end_line
end

-- Get the selected text in visual mode as string list.
function M.get_visual_selected()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  return vim.fn.getregion(start_pos, end_pos, { type = vim.fn.mode() })
end

-- Return to normal mode from visual mode and search the visually
-- selected text (first line if multi-line).
function M.search_selected()
  local text = M.get_visual_selected()
  if not text then
    return
  end
  for _, line in ipairs(text) do
    M.return_to_normal_mode()
    vim.api.nvim_feedkeys("/" .. line .. enter, "n", false)
    return
  end
end

function M.toggle_gutter()
  local signcolumn = vim.wo.signcolumn
  local number = vim.wo.number
  local relativenumber = vim.wo.relativenumber

  -- Toggle signcolumn between 'yes' and 'no'
  if signcolumn == "yes" or signcolumn == "auto" then
    vim.wo.signcolumn = "no"
  else
    vim.wo.signcolumn = "yes"
  end

  -- Toggle line numbers
  if number or relativenumber then
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end

function M.fix_whitespace()
  local bufnr = 0 -- current buffer
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  for lnum = 1, line_count do
    local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]
    if line then
      local trimmed = string.gsub(line, "%s+$", "")
      if trimmed ~= line then
        vim.api.nvim_buf_set_lines(bufnr, lnum - 1, lnum, false, { trimmed })
      end
    end
  end
end

return M
