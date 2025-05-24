return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },

  -- LSP Keymaps
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function()
      local keys = require("plugins.lsp.attach").get()
      -- keys[#keys + 1] = {
      --   "<leader>cr",
      --   function()
      --     local inc_rename = require "inc_rename"
      --     return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand "<cword>"
      --   end,
      --   expr = true,
      --   desc = "Rename (inc-rename.nvim)",
      --   has = "rename",
      -- }
      vim.list_extend(keys, {
        {
          "grN",
          function() Snacks.rename.rename_file() end,
          desc = "Rename File",
          mode = { "n" },
          has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        },
      })
    end,
  },

  --- Noice integration
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      presets = { inc_rename = true },
    },
  },
}
