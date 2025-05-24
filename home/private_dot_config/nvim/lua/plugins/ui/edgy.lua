return {
  -- edgy
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>ue",
        function() require("edgy").toggle() end,
        desc = "Edgy Toggle",
      },
      -- stylua: ignore
      { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
      { "<D-b>", function() require("edgy").toggle "left" end, mode = { "n", "i" }, desc = "Toggle Left Edgy" },
      { "<D-r>", function() require("edgy").toggle "right" end, mode = { "n", "i" }, desc = "Toggle Right Edgy" },
      { "<D-j>", function() require("edgy").toggle "bottom" end, mode = { "n", "i" }, desc = "Toggle Bottom Edgy" },
      { "<A-D-y>", function() require("edgy").close() end, mode = { "n", "i" }, desc = "Closs All Edgy" },
    },
    opts = {
      bottom = {
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- don't open help files in edgy that we're editing
          filter = function(buf) return vim.bo[buf].buftype == "help" end,
        },
      },
      keys = {
        -- increase width
        ["<C-w><S-.>"] = function(win) win:resize("width", 2) end,
        -- decrease width
        ["<C-w><S-,>"] = function(win) win:resize("width", -2) end,
        -- increase height
        ["<C-w><S-=>"] = function(win) win:resize("height", 2) end,
        -- decrease height
        ["<C-w>-"] = function(win) win:resize("height", -2) end,
      },
    },
  },

  -- Fix bufferline offsets when edgy is loaded
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require "bufferline.offset"
      if not Offset.edgy then
        local get = Offset.get
        Offset.get = function()
          if package.loaded.edgy then
            local old_offset = get()
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs { "left", "right" } do
              local sb = layout[pos]
              local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
              if sb and #sb.wins > 0 then
                ret[pos] = old_offset[pos .. "_size"] > 0 and old_offset[pos]
                  or pos == "left" and ("%#Bold#" .. title .. "%*" .. "%#BufferLineOffsetSeparator#│%*")
                  or pos == "right" and ("%#BufferLineOffsetSeparator#│%*" .. "%#Bold#" .. title .. "%*")
                ret[pos .. "_size"] = old_offset[pos .. "_size"] > 0 and old_offset[pos .. "_size"] or sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then return ret end
          end
          return get()
        end
        Offset.edgy = true
      end
    end,
  },
}
