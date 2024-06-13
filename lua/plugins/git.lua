return {
  -- git differ
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = {
      enhanced_diff_hl = true,
      merge_tool = {
        layout = "diff3_horizontal",
        disable_diagnostics = true,
      },
    },
  },
}
