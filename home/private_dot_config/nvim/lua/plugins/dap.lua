return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>" },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>" },
      { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>" },
      { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>" },
      { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>" },
      { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>" },
      { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>" },
      { "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>" },
    },
    config = true,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    keys = {
      { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>" },
    },
    config = function()
      local sign = vim.fn.sign_define

      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
