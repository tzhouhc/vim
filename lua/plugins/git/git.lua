return {
  -- git differ
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
        hooks = { -- See ':h diffview-config-hooks'
          view_opened = function()
            require("diffview.actions").toggle_files()
          end,
        },
      })

      local function toggle_diffview()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewFileHistory %")
        else
          vim.o.hidden = true
          vim.cmd("DiffviewClose")
          vim.o.hidden = false
        end
      end

      vim.keymap.set("n", "<leader>dv", toggle_diffview, { noremap = true, silent = true })
    end,
  },
}
