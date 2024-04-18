local M = {}

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
      -- this _does_ require remapping from tree-sitter's text object seeking.
      -- we go to end of line the seek backwards since we want to avoid the
      -- situation where we are already at a comment.outer and `]c` jumps to the
      -- *next* one after that.
      --
      -- Note that if called on a line without a comment it will jump way out.
      vim.api.nvim_feedkeys("$[tf l", 'M', false)
    end,
  }

  behaviors[vim.g.alternating_zero_state]()
  vim.g.alternating_zero_state = vim.g.alternating_zero_state + 1
  if vim.g.alternating_zero_state > 3 then
    vim.g.alternating_zero_state = 1
  end
end

return M
