local function dashboard_key_conf(key, icon, text, action)
  local res = {
    key = key,
    icon = icon,
    desc = text,
    action = action,
  }
  return res
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
    opts = {
      -- https://github.com/folke/snacks.nvim?tab=readme-ov-file#-features
      -- for more components to enable
      bigfile = { enabled = true },
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
        enabled = true,
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
        }
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
      scroll = { enabled = true },
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
    },
  }
}
