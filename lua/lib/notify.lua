-- Functions for performing notifications, e.g. via noice

local M = {}

function M.popup(content)
  require("noice").notify(content, "󰍡")
end

function M.noice_hover(content)
  require("noice").redirect(function()
    print(content) -- always a msg_show event
  end, {
    {
      view = "timid_hover",
      filter = { event = "msg_show" },
    },
  })
end

function M.notify_hover(content)
  require("noice").notify(content, "info", {
    on_open = M.window_auto_close
  })
end

return M
