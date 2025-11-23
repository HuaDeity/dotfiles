vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
})

local dap = require "dap"
---@param session dap.Session
dap.listeners.after.event_initialized["store_config"] = function(session) vim.g.dap_last_config = session.config end
local function dap_continue()
  if vim.g.dap_last_config then
    dap.run(vim.g.dap_last_config)
  else
    dap.continue()
  end
end

vim.keymap.set("n", "<F4>", function() dap.continue() end, { desc = "Run" })
vim.keymap.set("n", "<F5>", function() dap_continue() end, { desc = "Continue" })
vim.keymap.set("n", "<S-F5>", function() dap.terminate() end, { desc = "Terminate Session" })
vim.keymap.set("n", "<S-D-F5>", function() dap.restart() end, { desc = "Restart Session" })
vim.keymap.set("n", "<F6>", function() dap.pause() end, { desc = "Pause" })
vim.keymap.set("n", "<F7>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F9>", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set(
  "n",
  "<S-F9>",
  function() dap.set_breakpoint(nil, nil, vim.fn.input "Log breakpoint message: ") end,
  { desc = "Edit Log Breakpoint" }
)
vim.keymap.set("n", "<C-F11>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<S-F11>", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>du", function() require("dap-view").toggle() end, { desc = "Dap View" })
vim.keymap.set({ "n", "x" }, "<leader>de", function() require("dap-view").add_expr() end, { desc = "Eval" })

-- Change breakpoint icons
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

local icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  -- "●"
  Breakpoint = { " ", "DapBreakpoint" },
  -- "●"
  BreakpointCondition = { " ", "DapBreakpointCondition" },
  -- "◆"
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = { ".>", "DapLogPoint" },
}

for name, sign in pairs(icons) do
  vim.fn.sign_define(
    "Dap" .. name,
    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
  )
end

---@diagnostic disable-next-line: duplicate-set-field
require("dap.ext.vscode").json_decode = function(str)
  return vim.json.decode(require("plenary.json").json_strip_comments(str))
end

require("dap-view").setup {
  auto_toggle = true,
  winbar = {
    controls = {
      enabled = true,
    },
  },
}

require("nvim-dap-virtual-text").setup {}

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
  callback = function(evt) vim.keymap.set("n", "q", "<C-w>q", { buffer = evt.buf }) end,
})
