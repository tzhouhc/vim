local misc = require("lib.misc")
local M = {}

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

function M.get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

-- three states: start of line, start of non-spaces, first after comment
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

function M.toggle_diffview()
  if next(require("diffview.lib").views) == nil then
    vim.cmd("DiffviewFileHistory %")
  else
    vim.o.hidden = true
    vim.cmd("DiffviewClose")
    vim.o.hidden = false
  end
end

function M.vsnip_jump_forward()
  if vim.fn["vsnip#jumpable"](1) == 1 then
    return "<plug>(vsnip-jump-next)"
  else
    return "<c-right>"
  end
end

function M.vsnip_jump_backward()
  if vim.fn["vsnip#jumpable"](1) == 1 then
    return "<plug>(vsnip-jump-prev)"
  else
    return "<c-left>"
  end
end

function M.add_blank_line_after()
  local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row, row, false, { "" })
end

function M.add_blank_line_before()
  local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "" })
end

function M.toggle_quickfix()
  if misc.has_win_of_type("quickfix") then
    vim.cmd.cclose()
    return
  end
  vim.cmd.copen()
end

return M
