-- Visual Experience Configurations

---@diagnostic disable: missing-fields
-- theme
local safe_require = require('lib.meta').safe_require

-- other options
vim.opt.conceallevel=2
vim.opt.concealcursor="nc"
vim.opt.foldlevelstart=99
vim.opt.colorcolumn="80"

local function highclear(name)
  vim.cmd("hi clear "..name)
end

local function highlight(name, vis)
  vim.cmd("highlight " .. name .. " " .. vis)
end

-- italics
highlight("Special", "gui=italic")
highlight("Comment", "gui=italic")
highlight("Italic", "gui=italic")
highlight("Bold", "gui=bold")
highlight("mkdBold", "gui=bold")
highlight("htmlItalic", "gui=italic")

-- signify
highlight("SignifySignAdd", "guifg=#2dd671")
highlight("SignifySignDelete", "guifg=#d94a0d")
highlight("SignifySignChange", "guifg=#e6bf12")

if vim.api.nvim_win_get_option(0, "diff") then
  vim.opt.diffopt="filler,context:1000000"
end

-- rainbow delimiters
highlight("RainbowDelim0", "guifg=#F6ED56")
highlight("RainbowDelim1", "guifg=#A6C955")
highlight("RainbowDelim2", "guifg=#4BA690")
highlight("RainbowDelim3", "guifg=#4191C9")
highlight("RainbowDelim4", "guifg=#2258A0")
highlight("RainbowDelim5", "guifg=#654997")
highlight("RainbowDelim6", "guifg=#994D95")
highlight("RainbowDelim7", "guifg=#D45196")
highlight("RainbowDelim8", "guifg=#DB3A35")
highlight("RainbowDelim9", "guifg=#E5783A")
highlight("RainbowDelim10", "guifg=#EC943F")
highlight("RainbowDelim11", "guifg=#F7C247")

safe_require('rainbow-delimiters.setup').setup {
  highlight = {
    'RainbowDelim0',
    'RainbowDelim1',
    'RainbowDelim2',
    'RainbowDelim3',
    'RainbowDelim4',
    'RainbowDelim5',
    'RainbowDelim6',
    'RainbowDelim7',
    'RainbowDelim8',
    'RainbowDelim9',
    'RainbowDelim10',
    'RainbowDelim11',
  }
}

-- diffview
vim.opt.fillchars:append("diff:/")
local diffChangedForeground = "#F6ED56"
local diffChangedColor = "#41423F"
local diffAddedColor = "#38463F"
local diffRemovedColor = "#41343A"
local hlToClear = {
  "DiffAdd",
  "DiffChange",
  "DiffDelete",
  "DiffText",
}
for _, c in pairs(hlToClear) do
  highclear(c)
end

highlight("DiffAdd", "guibg="..diffAddedColor)
highlight("DiffChange", "guibg="..diffChangedColor)
highlight("DiffDelete", "guibg="..diffRemovedColor.." gui=strikethrough")
highlight("DiffText", "guibg="..diffChangedColor.." guifg="..diffChangedForeground.." gui=bold")

safe_require('diffview').setup {
  enhanced_diff_hl = true,
}

-- noice notification setup
safe_require'noice'.setup {
  cmdline = {
    enabled = true, -- enables the Noice cmdline UI
    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = {}, -- global options for the cmdline. See section on views
    ---@type table<string, CmdlineFormat>
    format = {
      -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
      -- view: (default is cmdline view)
      -- opts: any options passed to the view
      -- icon_hl_group: optional hl_group for the icon
      -- title: set to anything or empty string to hide
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = "󰍉 ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = "󰍉 ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
      telescope = { pattern = "^:%s*Telescope%s+", icon = "", kind = "search" },
      edit = { pattern = "^:%s*e%s+", icon = "󱇧" },
      input = {}, -- Used by input()
      -- lua = false, -- to disable a format, set to `false`
    },
  },
  messages = {
    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
    -- This is a current Neovim limitation.
    enabled = true, -- enables the Noice messages UI
    view = "mini", -- default view for messages
    view_error = "mini", -- view for errors
    view_warn = "mini", -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },
  popupmenu = {
    enabled = true, -- enables the Noice popupmenu UI
    ---@type 'nui'|'cmp'
    backend = "nui", -- backend to use to show regular cmdline completions
    ---@type NoicePopupmenuItemKind|false
    -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
    kind_icons = {}, -- set to `false` to disable icons
  },
  -- default options for require('noice').redirect
  -- see the section on Command Redirection
  ---@type NoiceRouteConfig
  redirect = {
    view = "popup",
    filter = { event = "msg_show" },
  },
  -- You can add any custom commands below that will be available with `:Noice command`
  ---@type table<string, NoiceCommand>
  commands = {
    history = {
      -- options for the message history that you get with `:Noice`
      view = "split",
      opts = { enter = true, format = "details" },
      filter = {
        any = {
          { event = "notify" },
          { error = true },
          { warning = true },
          { event = "msg_show", kind = { "" } },
          { event = "lsp", kind = "message" },
        },
      },
    },
    -- :Noice last
    last = {
      view = "popup",
      opts = { enter = true, format = "details" },
      filter = {
        any = {
          { event = "notify" },
          { error = true },
          { warning = true },
          { event = "msg_show", kind = { "" } },
          { event = "lsp", kind = "message" },
        },
      },
      filter_opts = { count = 1 },
    },
    -- :Noice errors
    errors = {
      -- options for the message history that you get with `:Noice`
     view = "popup",
      opts = { enter = true, format = "details" },
      filter = { error = true },
      filter_opts = { reverse = true },
    },
  },
  notify = {
    -- Noice can be used as `vim.notify` so you can route any notification like other messages
    -- Notification messages have their level and other properties set.
    -- event is always "notify" and kind can be any log level as a string
    -- The default routes will forward notifications to nvim-notify
    -- Benefit of using Noice for this is the routing and consistent history view
    enabled = true,
    view = "mini",
  },
  lsp = {
    progress = {
      enabled = true,
      -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
      -- See the section on formatting for more details on how to customize.
      --- @type NoiceFormat|string
      format = "lsp_progress",
      --- @type NoiceFormat|string
      format_done = "lsp_progress_done",
      throttle = 1000 / 30, -- frequency to update lsp progress message
      view = "mini",
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = false,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = false,
    },
    hover = {
      enabled = true,
      silent = true, -- set to true to not show a message if hover is not available
      view = nil, -- when nil, use defaults from documentation
      ---@type NoiceViewOptions
      opts = {}, -- merged with defaults from documentation
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
        luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
        throttle = 50, -- Debounce lsp signature help request by 50ms
      },
      view = nil, -- when nil, use defaults from documentation
      ---@type NoiceViewOptions
      opts = {}, -- merged with defaults from documentation
    },
    message = {
      -- Messages shown by lsp servers
      enabled = true,
      view = "mini",
      opts = {},
    },
    -- defaults for hover and signature help
    documentation = {
      view = "hover",
      ---@type NoiceViewOptions
      opts = {
        lang = "markdown",
        replace = true,
        render = "plain",
        format = { "{message}" },
        win_options = { concealcursor = "n", conceallevel = 3 },
      },
    },
  },
  markdown = {
    hover = {
      ["|(%S-)|"] = vim.cmd.help, -- vim help links
      ["%[.-%]%((%S-)%)"] = safe_require("noice.util").open, -- markdown links
    },
    highlights = {
      ["|%S-|"] = "@text.reference",
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
    },
  },
  health = {
    checker = true, -- Disable if you don't want health checks to run
  },
  smart_move = {
    -- noice tries to move out of the way of existing floating windows.
    enabled = true, -- you can disable this behaviour here
    -- add any filetypes here, that shouldn't trigger smart move.
    excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
  },
  ---@type NoicePresets
  presets = {
    -- you can enable a preset by setting it to true, or a table that will override the preset config
    -- you can also add custom presets that you can enable/disable with enabled=true
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
  ---@type NoiceConfigViews
  views = {}, ---@see section on views
  ---@type NoiceRouteConfig[]
  routes = {}, --- @see section on routes
  ---@type table<string, NoiceFilter>
  status = {}, --- @see section on statusline components
  ---@type NoiceFormatOptions
  format = {}, --- @see section on formatting
}
