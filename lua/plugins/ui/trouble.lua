return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "DiagnosticsList", "SymbolsList", "LSPList", "TodoList" },
    config = function()
      local tr = require("trouble")
      tr.setup({})

      vim.api.nvim_create_user_command("DiagnosticsList", "Trouble diagnostics toggle focus=false", {})
      vim.api.nvim_create_user_command("SymbolsList", "Trouble symbols toggle focus=false", {})
      vim.api.nvim_create_user_command("LSPList", "Trouble lsp toggle focus=false win.position=right", {})
      vim.api.nvim_create_user_command(
        "TodoList",
        "Trouble todo toggle focus=false win.position=right filter={tag={TODO,FIX,FIXME,HACK}}",
        {}
      )

      local ft = require("lib.ft")
      -- IF we are closing a regular window, which likely is the *primary*
      -- window, close all trouble views first.
      vim.api.nvim_create_autocmd({ "QuitPre" }, {
        callback = function(args)
          if ft.is_normal_buffer(args.buf) and ft.is_file_backed(args.buf) then
            local view = tr.close()
            while view do
              view = tr.close()
            end
          end
        end,
        group = vim.api.nvim_create_augroup("EnsureTroubleCloses", {}),
      })
    end
  }
}
