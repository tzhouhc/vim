local M = {}

function M.alternating_zero()
  -- initialize
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
      vim.api.nvim_feedkeys("^]cf l", 'M', false)
    end,
  }

  behaviors[vim.g.alternating_zero_state]()
  vim.g.alternating_zero_state = vim.g.alternating_zero_state + 1
  if vim.g.alternating_zero_state > 3 then
    vim.g.alternating_zero_state = 1
  end
end

return M
