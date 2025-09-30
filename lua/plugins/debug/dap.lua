local pretty_print = {
  {
    text = "-enable-pretty-printing",
    description = "enable pretty printing",
    ignoreFailures = false,
  },
}

return {
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapNew" },
    config = function()
      local dap = require("dap")
      local git = require("lib.git")

      -- uses `cpptools` from vsc; install using mason
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "OpenDebugAD7",
      }

      dap.configurations.c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", git.soft_git_repo_root() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          setupCommands = pretty_print,
        },
        {
          name = "Attach to gdbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "gdb",
          miDebuggerServerAddress = "localhost:1234",
          miDebuggerPath = "/usr/bin/gdb",
          cwd = "${workspaceFolder}",
          program = function()
            return vim.fn.input("Path to executable: ", git.soft_git_repo_root() .. "/", "file")
          end,
          setupCommands = pretty_print,
        },
      }
      dap.configurations.cpp = dap.configurations.c
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    cmd = { "DapUI" },
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      -- manual cmds for dapui
      vim.api.nvim_create_user_command("DapUIOpen", dapui.open, {})
      vim.api.nvim_create_user_command("DapUIClose", dapui.close, {})
      vim.api.nvim_create_user_command("DapUI", dapui.toggle, {})

      -- smart open/close based on dap
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
