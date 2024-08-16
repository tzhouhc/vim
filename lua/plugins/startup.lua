return {
  -- startup page
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
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
        dashboard.button("0", "  Scratch File", ":Scratch<CR>"),
        dashboard.button("1", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("2", "󰍉  Find File", ":Telescope find_files<CR>"),
        dashboard.button("3", "  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("4", "󰏗  Last Session", ":SessionLoadLast<CR>"),
        dashboard.button("5", "󰏗  Local Session", ":SessionLoadHere<CR>"),

        dashboard.button("y", "󰇥  File Explorer", ":Yazi<CR>"),
        dashboard.button("s", "󰏗  Select Session", ":SelectSession<CR>"),
        dashboard.button("g", "󰊢  Repositories", ":SelectFromRepositories<CR>"),
        dashboard.button("z", "󰚥  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "󰠚  Quit NVIM", ":qa<CR>"),
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
    end
  },
}
