return {
  -- transparent background
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = { "ColorColumn" }
    },
  },
  -- create vertical lines to mark indentation.
  "lukas-reineke/indent-blankline.nvim",
  -- rainbow colors for parentheses/brackets for easier depth determination
  "HiPhish/rainbow-delimiters.nvim",
  -- highlight hex colors
  { "norcalli/nvim-colorizer.lua", config = true, cmd = "ColorizerToggle" },
  -- smart dimming of unrelated contextual code
  { "folke/twilight.nvim",         config = true, cmd = "Twilight" },
}
