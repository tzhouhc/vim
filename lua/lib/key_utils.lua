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

function M.alternating_zero()
  -- initialize global var for alternating
  if vim.g.alternating_zero_state == nil then
    vim.g.alternating_zero_state = 1
  end

  -- three states: start of line, start of non-spaces, first after comment
  local behaviors = {
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

  behaviors[vim.g.alternating_zero_state]()
  vim.g.alternating_zero_state = vim.g.alternating_zero_state + 1
  if vim.g.alternating_zero_state > 3 then
    vim.g.alternating_zero_state = 1
  end
end

function M.smarter_shift_i()
  local syns = vim.inspect_pos()  -- assume default: current buffer, on cursor
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

return M
