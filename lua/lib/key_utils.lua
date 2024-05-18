local safe_require = require('lib.meta').safe_require

local M = {}

function M.go_to_start_of_comment()
  -- this _does_ require remapping from tree-sitter's text object seeking.
  -- we go to end of line the seek backwards since we want to avoid the
  -- situation where we are already at a comment.outer and `]c` jumps to the
  -- *next* one after that.
  --
  -- Note that if called on a line without a comment it will jump way out.
  vim.api.nvim_feedkeys("$[tf l", 'M', false)
end

function M.get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

-- three states: start of line, start of non-spaces, first after comment
local alternating_zero_behaviors = {
  function()
    vim.api.nvim_feedkeys("0", 'n', false)
  end,
  function()
    vim.api.nvim_feedkeys("^", 'n', false)
  end,
  function()
    M.go_to_start_of_comment()
  end,
}

function M.alternating_zero()
  -- we maintain the same start for each distinct row we run this in
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
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
  for _, syn in ipairs(syns['treesitter']) do
    print(vim.inspect(syn))
    if syn['capture'] == 'comment' then
      M.go_to_start_of_comment()
      vim.api.nvim_feedkeys("i", 'n', false)
      return
    end
  end
  vim.api.nvim_feedkeys("I", 'n', false)
end

function M.toggle_diffview()
  if next(safe_require('diffview.lib').views) == nil then
    vim.cmd('DiffviewFileHistory %')
  else
    vim.o.hidden = true
    vim.cmd('DiffviewClose')
    vim.o.hidden = false
  end
end

function M.vsnip_jump_forward()
  if vim.fn["vsnip#jumpable"](1) == 1 then
    return'<plug>(vsnip-jump-next)'
  else
    return "<c-right>"
  end
end

function M.vsnip_jump_backward()
  if vim.fn["vsnip#jumpable"](1) == 1 then
    return'<plug>(vsnip-jump-prev)'
  else
    return "<c-left>"
  end
end

return M
