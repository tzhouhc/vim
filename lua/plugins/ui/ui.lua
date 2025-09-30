return {
  -- visuals
  -- highlight TODOs
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cond = not not vim.g.enable_todo_highlights,
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = "󱨈 ", color = "warning" },
        DONE = { icon = " ", color = "hint", alt = { "GOOD", "OK" } },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
    }
  },
  -- peek line number
  {
    'nacro90/numb.nvim',
    cond = not not vim.g.enable_peek_line_number,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = true,
  },
  -- smarter folding
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    cond = not not vim.g.enable_ufo,
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d lines '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      require("ufo").setup(
        {
          provider_selector = function(_, ft, _)
            if ft == "python" then
              return { "indent" }
            elseif ft == "markdown" then
              return { "treesitter" }
            end
            return { "treesitter", "indent" }
          end,
          close_fold_kinds_for_ft = {
            default = { 'imports', 'comment' },
          },
          fold_virt_text_handler = handler
        }
      )
    end
  },
  {
    "sphamba/smear-cursor.nvim",
    cond = not not vim.g.smear_cursor,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      smear_between_buffers = false,
      cursor_color = "#ff8800",
      stiffness = 0.4,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      never_draw_over_target = true,
      hide_target_hack = true,
      gamma = 1,
      legacy_computing_symbols_support = true,
      smear_insert_mode = false,
      min_horizontal_distance_smear = 2,
      min_vertical_distance_smear = 2,
    },
  },
  {
    "tzhouhc/virt-counter.nvim",
    cond = not not vim.g.visual_wordcount,
    config = function()
      local vt = require("virt-counter")
      vt.setup({
        count_newlines = true,
        preset = "pill",
      })
      vim.keymap.set("v", "<space>", vt.refresh, {})
    end
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "LspAttach",
    config = function()
      local gp = require('goto-preview')
      gp.setup({
        width = 90,
        height = 15,
        references = {
          provider = vim.g.use_fzf_for_lsp and "fzf_lua" or "default",
          -- telescope|fzf_lua|snacks|mini_pick|default
        },
      })

      local lsp_key_config = {
        n = {
          ["gF"] = gp.goto_preview_declaration,
          ["gD"] = gp.goto_preview_definition,
          ["gI"] = gp.goto_preview_implementation,
          ["gT"] = gp.goto_preview_type_definition,
          ["gR"] = gp.goto_preview_references,
          ["g<esc>"] = gp.close_all_win,
        }
      }
      require("lib.binder").batch_set_keymap(lsp_key_config)
    end,
  },
  {
    "nvimtools/hydra.nvim",
  }
}
