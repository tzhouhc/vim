return {
  {
    "ruifm/gitlinker.nvim",
    config = function()
      local gl = require("gitlinker")
      local copy_url_and_open = function(data)
        gl.actions.copy_to_clipboard(data)
        gl.actions.open_in_browser(data)
      end
      gl.setup()
      vim.api.nvim_create_user_command("GetGithubLinkToLine", function()
        gl.get_buf_range_url("n", {action_callback = copy_url_and_open})
      end, {})
      vim.api.nvim_create_user_command("GetGithubLink", function()
        gl.get_repo_url({action_callback = copy_url_and_open})
      end, {})
    end,
  }
}
