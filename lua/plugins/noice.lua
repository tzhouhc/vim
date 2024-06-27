-- Noice notification setup

---@diagnostic disable: missing-fields
local noice_views = require("lib.noice_views").views

local cmdline_format = {
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
  help_custom = { pattern = "^:%s*H%s+", icon = "󰋖" },
  telescope = { pattern = "^:%s*Telescope%s+", icon = "", kind = "search" },
  edit = { pattern = "^:%s*e%s+", icon = "󱇧" },
  input = {}, -- Used by input()
  -- lua = false, -- to disable a format, set to `false`
}
local nfv2_format = {
  cmdline = { pattern = "^:", icon = "", lang = "vim" },
  search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
  search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
  filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
  lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
  help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
  help_custom = { pattern = "^:%s*H%s+", icon = "󰋖" },
  telescope = { pattern = "^:%s*Telescope%s+", icon = "", kind = "search" },
  edit = { pattern = "^:%s*e%s+", icon = "" },
  input = {}, -- Used by input()
}

if os.getenv("NERDFONT") == "2" then
  cmdline_format = nfv2_format
end

return {
  -- notifications
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enabled = true,         -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {},              -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = cmdline_format,
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true,               -- enables the Noice messages UI
        view = "minish",              -- default view for messages
        view_error = "topright_mini", -- view for errors
        view_warn = "topright_mini",  -- view for warnings
        view_history = "messages",    -- view for :messages
        view_search = "virtualtext",  -- view for search count messages. Set to `false` to disable
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "minish",
          opts = {},
        },
      },
      ---@type NoiceConfigViews
      views = noice_views, ---@see section on views
      ---@type NoiceRouteConfig[]
      routes = {
        {
          -- for "msg_show" that is too long, throw into a temp hover in the top
          -- right of screen.
          filter = {
            event = "msg_show",
            min_height = 5,
          },
          view = "temp_corner_popup",
          opts = {
            close = {
              events = { "CursorMoved" },
            },
          },
        },
        {
          -- similar to above, but length-wise.
          filter = {
            event = "msg_show",
            min_length = 100,
          },
          view = "temp_corner_popup",
          opts = {
            close = {
              events = { "CursorMoved" },
            },
          },
        },
      }, --- @see section on routes
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,          -- use a classic bottom cmdline for search
        command_palette = true,        -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,         -- add a border to hover docs and signature help
      },
    }
  },
}
