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
    config = function()
      require("colorizer").setup({})
      -- visuals.lua get colorizer started automatically on file open
      vim.api.nvim_create_autocmd(
        { "BufReadPost", "BufNewFile", "BufWritePre" },
        {
          pattern = {
            "*.css",
            "visuals.lua", -- vim / wezterm visual configs
            "prompt.json", -- oh-my-posh prompt configs
            "rainbow.lua",
          },
          callback = function()
            vim.cmd("ColorizerAttachToBuffer")
          end,
          group = vim.api.nvim_create_augroup("AutoColorizer", { clear = true }),
        }
      )
    end,
  },
  -- smart dimming of unrelated contextual code
  {
    "folke/twilight.nvim",
    config = true,
    cmd = "Twilight",
  },
}
