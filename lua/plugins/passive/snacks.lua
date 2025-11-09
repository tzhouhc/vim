local ft = require("lib.ft")

local function dashboard_key_conf(key, icon, text, action)
  local res = {
    key = key,
    icon = icon,
    desc = text,
    action = action,
  }
  return res
end

-- this is needed to prevent the situation where vim tries to `e#-1` but the
-- target is Neotree or some such non-file.
local function open_last_actual_file()
  for _, file in ipairs(vim.api.nvim_get_vvar("oldfiles")) do
    if ft.is_file(file) then
      vim.cmd("edit " .. file)
      -- only open one then just stop
      return
    end
  end
  vim.notify("No oldfile found.", vim.log.levels.ERROR, {})
end

local dash_header =
    "        ██            ██                          \n" ..
    "      ██░░██        ██░░██                        \n" ..
    "      ██░░▒▒████████▒▒░░██                ████    \n" ..
    "    ██▒▒░░░░▒▒▒▒░░▒▒░░░░▒▒██            ██░░░░██  \n" ..
    "    ██░░░░░░░░░░░░░░░░░░░░██            ██  ░░██  \n" ..
    "  ██▒▒░░░░░░░░░░░░░░░░░░░░▒▒████████      ██▒▒██  \n" ..
    "  ██░░  ██  ░░██░░  ██  ░░  ▒▒  ▒▒  ██    ██░░██  \n" ..
    "  ██░░░░░░░░██░░██░░░░░░░░░░▒▒░░▒▒░░░░██████▒▒██  \n" ..
    "  ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░██    \n" ..
    "  ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░██    \n" ..
    "  ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██      \n" ..
    "  ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██      \n" ..
    "  ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██      \n" ..
    "  ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒██      \n" ..
    "    ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒██        \n" ..
    "      ██▒▒░░▒▒▒▒░░▒▒░░░░░░▒▒░░▒▒▒▒░░▒▒██          \n" ..
    "        ██░░████░░██████████░░████░░██            \n" ..
    "        ██▓▓░░  ▓▓██░░  ░░██▓▓  ░░▓▓██            \n"

local dash_keys = {
  dashboard_key_conf("1", "", "New File", ":ene"),
  dashboard_key_conf("2", "󰍉", "Find File", ":FzfLua files"),
  dashboard_key_conf("3", "", "Last File", open_last_actual_file),
  dashboard_key_conf("4", "󰏗", "Last Session", ":SessionLoadLast"),
  dashboard_key_conf("5", "󰏗", "Local Session", ":SessionLoadHere"),
  dashboard_key_conf("r", "", "Recent Files", ":FzfLua oldfiles"),
  dashboard_key_conf("y", "󰇥", "File Explorer", ":Yazi"),
  dashboard_key_conf("s", "󰏗", "Select Session", ":SelectSession"),
  dashboard_key_conf("z", "󰚥", "Lazy", ":Lazy"),
  dashboard_key_conf("q", "󰠚", "Quit NVIM", ":qa"),
}

local term_keys = {
  q = "hide",
  gf = function(self)
    local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
    if f == "" then
      require("snacks.notify").warn("No file under cursor")
    else
      self:hide()
      vim.schedule(function()
        vim.cmd("e " .. f)
      end)
    end
  end,
  term_normal = {
    "<esc>",
    function(self)
      self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
      if self.esc_timer:is_active() then
        self.esc_timer:stop()
        vim.cmd("stopinsert")
      else
        self.esc_timer:start(200, 0, function() end)
        return "<esc>"
      end
    end,
    mode = "t",
    expr = true,
    desc = "Double escape to normal mode",
  },
}

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
      "folke/persistence.nvim",
    },
    config = function()
      require('snacks').setup({
        -- https://github.com/folke/snacks.nvim?tab=readme-ov-file#-features
        -- for more components to enable
        bigfile = { enabled = false },
        dashboard = {
          enabled = true,
          preset = {
            header = dash_header,
            -- [[string]] does not play nicely with uneven lengthed strings,
            -- and auto-fix-whitespace won't let me leave spaces at the end.
            keys = dash_keys,
          },
          sections = {
            { section = "header" },
            { section = "keys",   gap = 1, padding = 1 },
            { section = "startup" },
          },
        },
        indent = {
          cond = not not vim.g.enable_rainbow_indent,
          char = "┆",
          only_scope = true,
          only_current = true,
          indent = {
            hl = (function()
              local groups = {}
              for i = 1, 12 do
                groups[i] = "RainbowDarkDelim" .. i
              end
              return groups
            end)()
          },
          animate = {
            enabled = false,
          },
          scope = {
            char = "┆",
            only_current = true,
            -- safe to keep permanently after
            -- https://github.com/folke/snacks.nvim/issues/422 is resolved
            hl = (function()
              local groups = {}
              for i = 1, 12 do
                groups[i] = "RainbowDelim" .. i
              end
              return groups
            end)()
          },
          chunk = {
            enabled = true,
            -- only show chunk scopes in the current window
            only_current = true,
            priority = 200,
            hl = (function()
              local groups = {}
              for i = 1, 12 do
                groups[i] = "RainbowDelim" .. i
              end
              return groups
            end)(),
            char = {
              corner_top = "┌",
              corner_bottom = "└",
              -- corner_top = "╭",
              -- corner_bottom = "╰",
              horizontal = "─",
              vertical = "│",
              arrow = "",
            },
          },
        },
        input = {
          icon = " ",
          icon_hl = "SnacksInputIcon",
          icon_pos = "left",
          prompt_pos = "title",
          win = { style = "input" },
          expand = true,
        },
        lazygit = {
          enabled = true,
          configure = true,
        },
        -- notifier = { enabled = true },
        -- disabled since it does not have everything from noice
        quickfile = { enabled = true },
        rename = { enabled = true },
        -- double not to cast as bool
        scroll = { enabled = not not vim.g.animate_scroll },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
          terminal = {
            border = "rounded",
            bo = {
              filetype = "snacks_terminal",
            },
            wo = {},
            keys = term_keys,
            fixbuf = true,
          },
          right_term = {
            height = 0.9,
            width = 0.45,
            col = 0.5,
            row = 0.025,
            position = "float",
            border = "rounded",
            bo = {
              filetype = "snacks_terminal",
            },
            wo = {},
            keys = term_keys,
            fixbuf = true,
          }
        }
      })
      local terms = require("lib.plugin.snacks")
      local key_configs = {
        -- Normal mode
        n = {
          -- quake term
          ["<m-e>"] = terms.quake_term,
          -- local fuzzy find
          ["<m-f>"] = terms.repo_live_grep,
        }
      }
      require("lib.binder").batch_set_auto_buf_keymap(key_configs, "snacks")

      vim.api.nvim_create_user_command("Git", function() require("snacks.lazygit").open() end, {})
      vim.api.nvim_create_user_command("RenameFile", require("snacks.rename").rename_file, {})

      -- Git Tools
      vim.api.nvim_create_user_command("GitLinesLogs", terms.git_lines_log, { range = true })
      vim.api.nvim_create_user_command("GitLinesBlame", terms.git_lines_blame, { range = true })

      -- Others
      vim.api.nvim_create_user_command("Seb", terms.global_file_list, { range = true })
      vim.api.nvim_create_user_command("QQ", terms.mods_chat, {})
      vim.api.nvim_create_user_command("FloatRight", terms.right_side_term, {})
      vim.api.nvim_create_user_command("IndentlineToggle", function()
        Snacks.indent.enabled = not Snacks.indent.enabled
        vim.cmd("redraw!")
      end, {})
    end,
  }
}
