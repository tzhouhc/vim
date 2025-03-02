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
      hooks = {     -- See ':h diffview-config-hooks'
        view_opened = function()
          require("diffview.actions").toggle_files()
        end,
      },
    },
  },
}
