return {
  -- transparent background
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = { "ColorColumn" }
    },
  },
  -- rainbow colors for parentheses/brackets for easier depth determination
  { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile", "BufWritePre" } },
  -- highlight hex colors
  { "norcalli/nvim-colorizer.lua",     config = true,     cmd = "ColorizerToggle" },
  -- smart dimming of unrelated contextual code
  { "folke/twilight.nvim",             config = true,     cmd = "Twilight" },
}
