return {
  -- icons
  {
    "nvim-tree/nvim-web-devicons",
    tag = function()
      if vim.g.nerdfont_v2_compat then
        return "nerd-v2-compat"
      end
    end,
  }
}
