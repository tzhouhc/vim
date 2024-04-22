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
}

return M
