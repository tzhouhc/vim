local function check_date_passed(check_date)
  -- Accepts formats: "M-D", "MM-DD", "YYYY-M-D", "YYYY-MM-DD"
  local year, month, day

  -- Match "YYYY-M-D" or "YYYY-MM-DD"
  year, month, day = check_date:match("^(%d%d%d%d)%-(%d%d?)%-(%d%d?)$")
  if year then
    year = tonumber(year)
    month = tonumber(month)
    day = tonumber(day)
  else
    -- Match "M-D" or "MM-DD"
    month, day = check_date:match("^(%d%d?)%-(%d%d?)$")
    if not (month and day) then
      return false
    end
    local current_year = os.date("*t").year
    year = current_year
    month = tonumber(month)
    day = tonumber(day)
  end

  -- Build timestamps and compare as before
  local date_ts = os.time({ year = year, month = month, day = day, hour = 0 })
  local now = os.date("*t")
  local today_ts = os.time({ year = now.year, month = now.month, day = now.day, hour = 0 })

  return date_ts <= today_ts
end

return {
  {
    "ruifm/gitlinker.nvim",
    cmd = { "GetGithubLink", "GetGithubLinkToLine" },
    config = function()
      local gl = require("gitlinker")
      local copy_url_and_open = function(data)
        gl.actions.copy_to_clipboard(data)
        gl.actions.open_in_browser(data)
      end
      gl.setup()
      vim.api.nvim_create_user_command("GetGithubLinkToLine", function()
        gl.get_buf_range_url("n", { action_callback = copy_url_and_open })
      end, {})
      vim.api.nvim_create_user_command("GetGithubLink", function()
        gl.get_repo_url({ action_callback = copy_url_and_open })
      end, {})
    end,
  },
  {
    "tzhouhc/checkmate.nvim",
    ft = "markdown",
    config = function()
      opts = {
        files = { "*tasks.md" },
        keys = {
          ["gt"] = {
            rhs = "<cmd>Checkmate toggle<CR>",
            desc = "Toggle todo item",
            modes = { "n", "v" },
          },
          ["g]"] = {
            rhs = "<cmd>Checkmate cycle_next<CR>",
            desc = "Cycle todo item(s) to the next state",
            modes = { "n", "v" },
          },
          ["g["] = {
            rhs = "<cmd>Checkmate cycle_previous<CR>",
            desc = "Cycle todo item(s) to the previous state",
            modes = { "n", "v" },
          },
        },
        metadata = {
          review = {
            style = { fg = "#eed49f" },
            get_value = function()
              -- tomorrow's date (a very naive implementation)
              local t = os.date("*t")
              t.day = t.day + 1
              local tomorrow = os.time(t)
              return os.date("%m-%d-%y", tomorrow)
            end,
          },
        },
        todo_states = {
          -- Built-in states (cannot change markdown or type)
          unchecked = { marker = "󰄱" },
          checked = { marker = "" },

          -- Custom states
          in_progress = {
            marker = "",
            markdown = ".", -- Saved as `- [.]`
            type = "incomplete", -- Counts as "not done"
            order = 2,
          },
          cancelled = {
            marker = "󰩹",
            markdown = "/",
            type = "complete",
            order = 4,
          },
          blocked = {
            marker = "󰥔",
            markdown = "-",
            type = "incomplete",
            order = 3,
          },
          reconsider = {
            marker = "",
            markdown = "?",
            type = "inactive",
            order = 5,
          },
          urgent = {
            marker = "",
            markdown = "!",
            type = "incomplete",
            order = 6,
          },
        },
        style = {
          CheckmateBlockedMarker = { fg = "#eed49f" },
          CheckmateBlockedMainContent = { fg = "#494d64" },
          CheckmateCancelledMarker = { fg = "#494d64" },
          CheckmateCancelledMainContent = { fg = "#494d64" },
          CheckmateCheckedMainContent = { fg = "#494d64" },
          CheckmateUrgentMarker = { fg = "#ed8796" },
          CheckmateUrgentMainContent = { fg = "#ed8796" },
        },
      }
      local checkmate = require("checkmate")
      checkmate.setup(opts)
      local picker = require("checkmate.picker")

      local function define_usercmd_for(name, opts)
        vim.api.nvim_create_user_command(name, function()
          local todos = checkmate.get_todos(opts)
          picker.pick(picker.map_items(todos, "text"), {
            method = "pick_todo",
            {},
          })
        end, {})
      end

      define_usercmd_for("CheckTodo", {
        filter = { states = { "unchecked", "in_progress", "urgent" } },
      })
      define_usercmd_for("CheckBlocked", {
        filter = { states = { "blocked" } },
      })

      vim.api.nvim_create_user_command("CheckRevisit", function()
        ---@type checkmate.Todo[]
        local todos = checkmate.get_todos({
          filter = { state_types = { "incomplete" } },
        })
        local filtered = {}
        for _, t in ipairs(todos) do
          -- note: use `.get_metadata` instead of `:get_metadata`
          local meta, check_date = t.get_metadata("review")
          -- check_date would be of the format "12-15" or "2025-12-15"
          if meta and check_date_passed(check_date) then
            filtered[#filtered + 1] = t
          end
        end
        picker.pick(picker.map_items(filtered, "text"), {
          method = "pick_todo",
          {},
        })
      end, {})
    end,
  },
}
