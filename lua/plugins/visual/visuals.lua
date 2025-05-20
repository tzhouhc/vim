return {
  -- transparent background
  {
    "xiyaowong/transparent.nvim",
    cond = not not vim.g.enable_transparency,
    opts = {
      extra_groups = { "ColorColumn" }
    },
  },
  -- rainbow colors for parentheses/brackets for easier depth determination
  {
    "HiPhish/rainbow-delimiters.nvim",
    cond = not not vim.g.enable_rainbow_paren,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
  -- highlight hex colors
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
    cmd = "ColorizerToggle",
  },
  -- smart dimming of unrelated contextual code
  {
    "folke/twilight.nvim",
    config = true,
    cmd = "Twilight",
  },
}
