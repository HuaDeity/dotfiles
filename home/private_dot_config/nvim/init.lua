if vim.env.PROF then
  local snacks = vim.fn.stdpath "data" .. "/site/pack/core/opt/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup {
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("TreesitterUpdate", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "nvim-treesitter" then vim.cmd "TSUpdate" end
  end,
  desc = "Treesitter: update parser automatically",
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("MCPHubInstall", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "mcphub.nvim" then
      vim.notify("Installing MCPHub CLI...", vim.log.levels.INFO)
      vim.system({ "npm", "i", "-g", "mcp-hub@latest" }, {
        text = true,
      }, function(result)
        if result.code == 0 then
          vim.schedule(function() vim.notify("MCPHub CLI installed successfully!", vim.log.levels.INFO) end)
        else
          vim.schedule(
            function() vim.notify("Failed to install MCPHub CLI: " .. (result.stderr or ""), vim.log.levels.ERROR) end
          )
        end
      end)
    end
  end,
  desc = "MCPHub: Install MCPHub CLI",
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("VectorCodeInstall", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "VectorCode" then
      vim.notify("Installing VectorCode CLI...", vim.log.levels.INFO)
      vim.system({ "uv", "tool", "install", "vectorcode", "-U" }, {
        text = true,
      }, function(result)
        if result.code == 0 then
          vim.schedule(function() vim.notify("VectorCode CLI installed successfully!", vim.log.levels.INFO) end)
          -- VectorCode setup is handled in codecompanion extensions
        else
          vim.schedule(
            function() vim.notify("Failed to install VectorCode CLI: " .. (result.stderr or ""), vim.log.levels.ERROR) end
          )
        end
      end)
    end
  end,
  desc = "VectorCode: Install VectorCode CLI",
})
