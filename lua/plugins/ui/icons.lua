if vim.g.nerdfont_v2_compat then
  return {
    -- icons
    {
      "nvim-tree/nvim-web-devicons",
      tag = "nerd-v2-compat",
    },
  }
else
  return {
    "nvim-tree/nvim-web-devicons",
  }
end
