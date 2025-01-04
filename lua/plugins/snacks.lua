local term_keys = {
  q = "hide",
  gf = function(self)
    local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
    if f == "" then
      Snacks.notify.warn("No file under cursor")
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

local function dashboard_key_conf(key, icon, text, action)
  local res = {
    key = key,
    icon = icon,
    desc = text,
    action = action,
  }
  return res
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- https://github.com/folke/snacks.nvim?tab=readme-ov-file#-features
      -- for more components to enable

      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header =
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
              "        ██▓▓░░  ▓▓██░░  ░░██▓▓  ░░▓▓██            \n",
          -- [[string]] does not play nicely with uneven lengthed strings,
          -- and auto-fix-whitespace won't let me leave spaces at the end.
          keys = {
            dashboard_key_conf("0", "", "Scratch File", ":Scratch"),
            dashboard_key_conf("1", "", "New File", ":ene <BAR> startinsert "),
            dashboard_key_conf("2", "󰍉", "Find File", ":Telescope find_files"),
            dashboard_key_conf("3", "", "Recent Files", ":Telescope oldfiles"),
            dashboard_key_conf("4", "󰏗", "Last Session", ":SessionLoadLast"),
            dashboard_key_conf("5", "󰏗", "Local Session", ":SessionLoadHere"),
            dashboard_key_conf("y", "󰇥", "File Explorer", ":Yazi"),
            dashboard_key_conf("s", "󰏗", "Select Session", ":SelectSession"),
            dashboard_key_conf("g", "󰊢", "Repositories", ":SelectFromRepositories"),
            dashboard_key_conf("z", "󰚥", "Lazy", ":Lazy"),
            dashboard_key_conf("q", "󰠚", "Quit NVIM", ":qa"),
          }
        },
        sections = {
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      indent = {
        enabled = true,
        char = "┆",
        only_scope = true, -- only show indent guides of the scope
        only_current = true,
        indent = {
          hl = {
            "RainbowDarkDelim1",
            "RainbowDarkDelim2",
            "RainbowDarkDelim3",
            "RainbowDarkDelim4",
            "RainbowDarkDelim5",
            "RainbowDarkDelim6",
            "RainbowDarkDelim7",
            "RainbowDarkDelim8",
            "RainbowDarkDelim9",
            "RainbowDarkDelim10",
            "RainbowDarkDelim11",
            "RainbowDarkDelim12",
          }
        },
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 10,
            total = 200,
          }
        },
        scope = {
          char = "┆",
          only_current = true,
          -- no idea why but the scope-based highlighting seems to be skipping
          -- groups? If the color ever goes back wrong again see if this was
          -- fixed.
          hl = {
            "RainbowDelim1",
            "RainbowDelim7",
            "RainbowDelim2",
            "RainbowDelim8",
            "RainbowDelim3",
            "RainbowDelim9",
            "RainbowDelim4",
            "RainbowDelim10",
            "RainbowDelim5",
            "RainbowDelim11",
            "RainbowDelim6",
            "RainbowDelim12",
          },
        }
      },
      input = { enabled = true },
      lazygit = {
        enabled = true,
        configure = true,
      },
      -- notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      -- words = { enabled = true },
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
    },
  }
}
