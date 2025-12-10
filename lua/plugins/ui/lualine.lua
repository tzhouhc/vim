return {
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "SmiteshP/nvim-navic" },
    config = function()
      local lines = require("lib.plugin.navic")

      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { "▎", "🮇" },
          section_separators = { "▎", "🮇" },
          always_divide_middle = true,
          globalstatus = true,
          disabled_filetypes = {
            winbar = {
              "dapui_watches",
              "dapui_stacks",
              "dapui_breakpoints",
              "dapui_scopes",
              "dapui_console",
              "dap-repl",
              "snacks_dashboard",
            },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              newfile_status = false, -- Display new file status (new file means no write after created)
              path = 3, -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              -- 4: Filename and parent dir, with tilde as the home directory

              shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              -- for other components. (terrible name, any suggestions?)
              symbols = {
                modified = "[+]", -- Text to show when the file is modified.
                readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                newfile = "[New]", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_y = { "filetype" },
          lualine_z = { "location" },
        },
        winbar = {
          lualine_b = {
            {
              lines.navic_status,
            },
          },
        },
        inactive_winbar = {
          lualine_b = {
            {
              lines.navic_status,
            },
          },
        },
      })
    end,
  },
}
