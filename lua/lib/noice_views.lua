-- Custom views for Noice
local M = {}

M.views = {
  -- customized version of mini that lasts for a bit longer
  minish = {
    backend = "mini",
    relative = "editor",
    align = "message-right",
    timeout = 5000, -- 5 seconds
    reverse = true,
    focusable = false,
    position = {
      row = -1,
      col = "100%",
      -- col = 0,
    },
    size = "auto",
    border = {
      style = "none",
    },
    zindex = 60,
    win_options = {
      winbar = "",
      foldenable = false,
      winblend = 30,
      winhighlight = {
        Normal = "NoiceMini",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
    },
  },
  -- customized version of mini that goes to the top-right of the screen
  topright_mini = {
    backend = "mini",
    relative = "editor",
    align = "message-right",
    timeout = 3000, -- 3 seconds
    reverse = true,
    focusable = false,
    position = {
      row = 1, -- don't overlay the bufferline
      col = "100%",
    },
    size = "auto",
    border = {
      style = "none",
    },
    zindex = 60,
    win_options = {
      winbar = "",
      foldenable = false,
      winblend = 30,
      winhighlight = {
        Normal = "NoiceMini",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
    },
  },
  -- popup in the top right corner that disappears upon <esc> or 30 seconds
  temp_corner_popup = {
    backend = "popup",
    relative = "editor",
    focusable = true,
    timeout = 30000, -- 30 seconds, allowing it to exit naturally
    enter = true,
    close = {
      -- the CursorMoved event is too sensitive and will instantly
      -- kill the popup if focused.
      -- events = { "CursorMoved" },
      keys = { "<esc>" },
    },
    zindex = 200,
    position = {
      row = "5%",
      col = "95%",
    },
    size = {
      width = "auto",
      height = "auto",
      max_height = "20",
      max_width = "80",
    },
    border = {
      style = "rounded",
      padding = { 0, 1 },
    },
    win_options = {
      winhighlight = {
        Normal = "NoiceCmdlinePopup",
        FloatTitle = "NoiceCmdlinePopupTitle",
        FloatBorder = "NoiceCmdlinePopupBorder",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
      winbar = "",
      foldenable = true,
      cursorline = false,
    },
  },
  -- temporary popup that soon disappears
  temp_popup = {
    backend = "popup",
    relative = "editor",
    focusable = false,
    timeout = 5000, -- 5 seconds
    enter = false,
    zindex = 200,
    position = {
      row = "20%",
      col = "50%",
    },
    size = {
      min_width = 60,
      width = "auto",
      height = "auto",
    },
    border = {
      style = "rounded",
      padding = { 0, 1 },
    },
    win_options = {
      winhighlight = {
        Normal = "NoiceCmdlinePopup",
        FloatTitle = "NoiceCmdlinePopupTitle",
        FloatBorder = "NoiceCmdlinePopupBorder",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
      winbar = "",
      foldenable = false,
      cursorline = false,
    },
  },
  -- custom version of the hover
  -- TODO: figure out if possible to close on CursorMoved event.
  temp_hover = {
    view = "popup",
    relative = "cursor",
    zindex = 45,
    enter = false,
    anchor = "auto",
    timeout = 5000,
    size = {
      width = "auto",
      height = "auto",
      max_height = 20,
      max_width = 120,
    },
    border = {
      style = "none",
      padding = { 0, 2 },
    },
    position = { row = 1, col = 0 },
    win_options = {
      wrap = true,
      linebreak = true,
    },
  },
}

return M
