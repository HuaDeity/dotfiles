vim.pack.add {
  "https://github.com/yioneko/nvim-vtsls",
}

vim.lsp.enable "vtsls"

-- treesitter
require("nvim-treesitter").install "typescript"

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug",
    args = { "${port}" },
  },
}

require("dap").configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}
