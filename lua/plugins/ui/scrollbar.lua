return {
  -- scroll-bar for checking location in file
  {
    "petertriho/nvim-scrollbar",
    cond = not not vim.g.enable_scrollbar,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      show_in_active_only = true,
      hide_if_all_visible = true, -- Hides everything if all lines are visible
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "",
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
        "fzf",
      },
    },
  },
}
