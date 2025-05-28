local middle_signs = {
  add          = { text = '┃' },
  change       = { text = '┃' },
  delete       = { text = '▁' },
  topdelete    = { text = '▔' },
  changedelete = { text = '┇' },
  untracked    = { text = '┆' },
}

local right_signs = {
  add          = { text = '🮇' },
  change       = { text = '🮇' },
  delete       = { text = '▁' },
  topdelete    = { text = '▔' },
  changedelete = { text = '🮇' },
  untracked    = { text = '▕' },
}

return {
  -- show lines that have been changed in the gutter
  {
    "lewis6991/gitsigns.nvim",
    cond = not not vim.g.enable_git_signs,
    config = function()
      require("gitsigns").setup({
        signs                        = middle_signs,
        signs_staged                 = middle_signs,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = true,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      })
      local df = require("lib.plugin.gitsigns")
      local key_configs = {
        -- Normal mode
        n = {
          -- move between change hunks
          ["[c"] = df.prev_hunk,
          ["]c"] = df.next_hunk,
        },
        [{ "o", "x" }] = {
          ["ih"] = ":<C-U>Gitsigns select_hunk<CR>",
        }
      }
      require("lib.binder").batch_set_auto_buf_keymap(key_configs, "diffhunks")
    end,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
}
