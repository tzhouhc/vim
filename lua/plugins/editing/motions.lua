return {
  -- motion
  -- % to jump to matching "pair"
  { "andymass/vim-matchup", keys = { "%", "n" } },
  -- overall better movement methods
  {
    "folke/flash.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      local f = require("flash")
      f.setup({ modes = { search = { enabled = false } } })
      -- ctrl/meta+j to select and go to one specific letter on screen
      vim.keymap.set({ "n", "v" }, "<c-j>", f.jump)
      vim.keymap.set({ "n", "v" }, "<m-j>", f.jump)
    end
  },
  -- quick jump to locally or globally recorded locations
  {
    "otavioschwanck/arrow.nvim",
    lazy = true,
    keys = { { ";", mode = "n" }, { ",", mode = "n" } },
    opts = {
      show_icons = true,
      always_show_path = false,
      separate_by_branch = false, -- Bookmarks will be separated by git branch
      hide_handbook = false,      -- set to true to hide the shortcuts on menu.
      save_path = function()
        return vim.fn.stdpath("cache") .. "/arrow"
      end,
      mappings = {
        edit = "e",
        delete_mode = "d",
        clear_all_items = "C",
        toggle = "s", -- used as save if separate_save_and_remove is true
        open_vertical = "v",
        open_horizontal = "-",
        quit = "q",
        -- remove = "x", -- only used if separate_save_and_remove is true
        next_item = "]",
        prev_item = "[",
      },
      custom_actions = {
        -- open = function(target_file_name, current_file_name) end, -- target_file_name = file selected to be open, current_file_name = filename from where this was called
        -- split_vertical = function(target_file_name, current_file_name) end,
        -- split_horizontal = function(target_file_name, current_file_name) end,
      },
      window = { -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
        width = "auto",
        height = "auto",
        row = "auto",
        col = "auto",
        border = "double",
      },
      per_buffer_config = {
        lines = 4,                      -- Number of lines showed on preview.
        sort_automatically = true,      -- Auto sort buffer marks.
        treesitter_context = nil,       -- it can be { line_shift_down = 2 }
      },
      separate_save_and_remove = false, -- if true, will remove the toggle and create the save/remove keymaps.
      leader_key = ";",
      buffer_leader_key = ",",
      save_key = "git_root",                                               -- what will be used as root to save the bookmarks. Can be also `git_root`.
      global_bookmarks = false,                                            -- if true, arrow will save files globally (ignores separate_by_branch)
      index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
      full_path_list = {},                                                 -- filenames on this list will ALWAYS show the file path too.
    },
  },
  {
    -- jump to relevant file
    "rgroli/other.nvim",
    cmd = { "Other" },
    config = function()
      require("other-nvim").setup({
        mappings = {
          {
            pattern = "/src/(.*).c",
            target = "/include/%1.h",
          },
          {
            pattern = "/src/(.*).h",
            target = "/include/%1.c",
          },
        },
      })
    end
  },
}
