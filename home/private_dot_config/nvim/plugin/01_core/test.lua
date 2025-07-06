vim.pack.add {
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/nvim-nio",
}

---@diagnostic disable: missing-fields
require("neotest").setup {
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = {
    open = function() require("trouble").open { mode = "quickfix", focus = false } end,
  },
  consumers = {
    trouble = function(client)
      client.listeners.results = function(adapter_id, results, partial)
        if partial then return end
        local tree = assert(client:get_position(nil, { adapter = adapter_id }))

        local failed = 0
        for pos_id, result in pairs(results) do
          if result.status == "failed" and tree:get_key(pos_id) then failed = failed + 1 end
        end
        vim.schedule(function()
          local trouble = require "trouble"
          if trouble.is_open() then
            trouble.refresh()
            if failed == 0 then trouble.close() end
          end
        end)
      end
      return {}
    end,
    overseer = function()
      require "neotest.consumers.overseer"
      return {}
    end,
  },
}

local neotest_ns = vim.api.nvim_create_namespace "neotest"
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      -- Replace newline and tab characters with space for more compact diagnostics
      local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)

-- stylua: ignore start
vim.keymap.set("n", "<leader>t", "", { desc = "+test" })
vim.keymap.set("n", "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run File (Neotest)" })
vim.keymap.set("n", "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, { desc = "Run All Test Files (Neotest)" })
vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run Nearest (Neotest)" })
vim.keymap.set("n", "<leader>tl", function() require("neotest").run.run_last() end, { desc = "Run Last (Neotest)" })
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Summary (Neotest)" })
vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, { desc = "Show Output (Neotest)" })
vim.keymap.set("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, { desc = "Toggle Output Panel (Neotest)" })
vim.keymap.set("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Stop (Neotest)" })
vim.keymap.set("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, { desc = "Toggle Watch (Neotest)" })
vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, { desc = "Debug Nearest" })
-- stylua: ignore end
