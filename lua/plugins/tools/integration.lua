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
    "bngarren/checkmate.nvim",
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
        todo_states = {
          -- Built-in states (cannot change markdown or type)
          unchecked = { marker = "󰄱" },
          checked = { marker = "" },

          -- Custom states
          in_progress = {
            marker = "",
            markdown = ".", -- Saved as `- [.]`
            type = "incomplete", -- Counts as "not done"
            order = 50,
          },
          cancelled = {
            marker = "󰩹",
            markdown = "/",
            type = "complete",
            order = 2,
          },
          pending = {
            marker = "󰥔",
            markdown = "-",
            type = "inactive",
            order = 100,
          },
          reconsider = {
            marker = "",
            markdown = "?",
            type = "inactive",
            order = 100,
          },
          urgent = {
            marker = "",
            markdown = "!",
            type = "inactive",
            order = 100,
          },
        },
      }
      local checkmate = require("checkmate")
      checkmate.setup(opts)
      local picker = require("checkmate.picker")
      vim.api.nvim_create_user_command("CheckmateTodos", function()
        local todos = checkmate.get_todos({
          filter = { state_types = { "incomplete" } },
        })
        picker.pick(picker.map_items(todos, "text"), {
          method = "pick_todo",
          {},
        })
      end, {})
    end,
  },
}
