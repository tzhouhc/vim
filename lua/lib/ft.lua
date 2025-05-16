-- Records the types of ft's and buft's that should be ignored for the purpose
-- of activating plugins, keymaps, completions, etc

local M = {}

M.special_filetypes = {
  "help",
  "man",
  "netrw",
  "NvimTree",
  "neo-tree",
  "fzf",
  "FzfLua",
  "Telescope",
  "fugitive",
  "dashboard",
  "startify",
  "alpha",
  "lspinfo",
  "oil"
  -- Add more as needed
}

M.special_buftypes = {
  "terminal",
  "nofile",
  "prompt",
  "quickfix",
  "help"
  -- Add more as needed
}

function M.is_normal_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Get buffer type/filetype
  local buf_type = vim.bo[bufnr].buftype
  local filetype = vim.bo[bufnr].filetype

  -- Check if the buffer is special
  for _, ft in ipairs(M.special_filetypes) do
    if filetype == ft then
      return false
    end
  end

  for _, bt in ipairs(M.special_buftypes) do
    if buf_type == bt then
      return false
    end
  end

  return true
end


return M
