if vim.g.theme == "nord" then
  return {
    -- the Neovim version of `nord` theme has better compatibility
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- load the color-scheme here
      vim.cmd([[colorscheme nord]])
    end,
  }
elseif vim.g.theme == "catppuccin" then
  -- catppuccin theme
  return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end
  }
else
  pcall(function()
    vim.cmd("colorscheme " .. vim.g.theme)
  end)
end
