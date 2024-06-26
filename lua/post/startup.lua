local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[                                                    ]],
  [[         ██            ██                           ]],
  [[       ██░░██        ██░░██                         ]],
  [[       ██░░▒▒████████▒▒░░██                ████     ]],
  [[     ██▒▒░░░░▒▒▒▒░░▒▒░░░░▒▒██            ██░░░░██   ]],
  [[     ██░░░░░░░░░░░░░░░░░░░░██            ██  ░░██   ]],
  [[   ██▒▒░░░░░░░░░░░░░░░░░░░░▒▒████████      ██▒▒██   ]],
  [[   ██░░  ██  ░░██░░  ██  ░░  ▒▒  ▒▒  ██    ██░░██   ]],
  [[   ██░░░░░░░░██░░██░░░░░░░░░░▒▒░░▒▒░░░░██████▒▒██   ]],
  [[   ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░██     ]],
  [[   ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░██     ]],
  [[   ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██       ]],
  [[   ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██       ]],
  [[   ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██       ]],
  [[   ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒██       ]],
  [[     ██▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒██         ]],
  [[       ██▒▒░░▒▒▒▒░░▒▒░░░░░░▒▒░░▒▒▒▒░░▒▒██           ]],
  [[         ██░░████░░██████████░░████░░██             ]],
  [[         ██▓▓░░  ▓▓██░░  ░░██▓▓  ░░▓▓██             ]],
  [[                                                    ]],
}

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
  dashboard.button("2", "󰍉  Find File", ":Telescope find_files<CR>"),
  dashboard.button("3", "  Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("4", "  Settings", ":VimConfigs<CR>"),
  dashboard.button("z", "󰚥  Lazy", ":Lazy<CR>"),
  dashboard.button("q", "󰠚  Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
