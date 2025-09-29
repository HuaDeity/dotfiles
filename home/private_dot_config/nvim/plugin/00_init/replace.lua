_G.dd = function(...) require("snacks.debug").inspect(...) end
_G.bt = function() require("snacks.debug").backtrace() end
_G.p = function(...) require("snacks.debug").profile(...) end
vim.print = _G.dd

require("direnv").setup{
  autoload_direnv = true,
}

package.preload["nvim-web-devicons"] = function()
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end

require("mini.icons").setup {
  directory = {
    Projects = { glyph = "" },
  },
  filetype = {
    octo = "",
  },
  file = {
    [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
    [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
    [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
    [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
    ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
    ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
    ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
  },
}

local pick_chezmoi = function()
  local results = require("chezmoi.commands").list {
    args = {
      "--path-style",
      "absolute",
      "--include",
      "files",
      "--exclude",
      "externals",
    },
  }
  local items = {}

  for _, czFile in ipairs(results) do
    table.insert(items, {
      text = czFile,
      file = czFile,
    })
  end

  ---@type snacks.picker.Config
  local opts = {
    items = items,
    confirm = function(picker, item)
      picker:close()
      require("chezmoi.commands").edit {
        targets = { item.text },
        args = { "--watch" },
      }
    end,
  }
  require("snacks").picker.pick(opts)
end
vim.keymap.set("n", "<leader>sz", function() pick_chezmoi() end, { desc = "Chezmoi" })
vim.keymap.set(
  "n",
  "<leader>un",
  function() require("snacks").notifier.hide() end,
  { desc = "Dismiss All Notifications" }
)
require("snacks").toggle.dim():map "<leader>uD"
require("snacks").toggle.animate():map "<leader>ua"
require("snacks").toggle.indent():map "<leader>ug"
require("snacks").toggle.scroll():map "<leader>uS"
require("snacks").toggle.zoom():map("<leader>wm"):map "<leader>uZ"
require("snacks").toggle.zen():map "<leader>uz"
require("snacks").toggle.option("spell", { name = "Spelling" }):map "<leader>us"
require("snacks").toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
-- stylua: ignore
require("snacks").toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map "<leader>uc"
-- stylua: ignore
require("snacks").toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map "<leader>uA"

local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function() vim.cmd.wincmd(dir) end)
  end
end

local notify = vim.notify
require("snacks").setup {
  animate = {},
  bigfile = {},
  dashboard = {
    preset = {
      ---@type snacks.dashboard.Item[]
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        -- stylua: ignore
        { icon = require("mini.icons").get("directory", "Projects"), key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()"},
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = require("mini.icons").get("directory", ".config"), key = "c", desc = "Config", action = pick_chezmoi },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
    },
  },
  explorer = {},
  image = {},
  indent = {},
  input = {},
  notifier = {},
  picker = {
    actions = {
      trouble_open = function(...) return require("trouble.sources.snacks").actions.trouble_open.action(...) end,
      flash = function(picker)
        require("flash").jump {
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
            },
          },
          action = function(match)
            local idx = picker.list:row2idx(match.pos[1])
            picker.list:_move(idx, true, true)
          end,
        }
      end,
    },
    win = {
      input = {
        keys = {
          ["<a-t>"] = { "trouble_open", mode = { "n", "i" } },
          ["<a-s>"] = { "flash", mode = { "n", "i" } },
          ["s"] = { "flash" },
        },
      },
    },
    sources = {
      explorer = {
        hidden = true,
        ignored = true,
      },
    },
  },
  quickfile = {},
  scope = {},
  scroll = {},
  terminal = {
    win = {
      keys = {
        nav_h = { "<C-h>", term_nav "h", desc = "Go to Left Window", expr = true, mode = "t" },
        nav_j = { "<C-j>", term_nav "j", desc = "Go to Lower Window", expr = true, mode = "t" },
        nav_k = { "<C-k>", term_nav "k", desc = "Go to Upper Window", expr = true, mode = "t" },
        nav_l = { "<C-l>", term_nav "l", desc = "Go to Right Window", expr = true, mode = "t" },
      },
    },
  },
}
vim.g.vim_picker = "snacks"
vim.notify = notify

require("noice").setup {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
    {
      filter = {
        event = "lsp",
        kind = "progress",
        cond = function(message)
          local client = vim.tbl_get(message.opts, "progress", "client")
          return client == "lua_ls"
        end,
      },
      opts = { skip = true },
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
  },
}

-- stylua: ignore start
vim.keymap.set("c", "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
vim.keymap.set("n", "<leader>snl", function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>snh", function() require("noice").cmd("history") end, { desc = "Noice History" })
vim.keymap.set("n", "<leader>sna", function() require("noice").cmd("all") end, { desc = "Noice All" })
vim.keymap.set("n", "<leader>snd", function() require("noice").cmd("dismiss") end, { desc = "Dismiss All" })
vim.keymap.set("n", "<leader>snt", function() require("noice").cmd("pick") end, { desc = "Noice Picker" })
vim.keymap.set({"i", "n", "s"}, "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, { silent = true, expr = true, desc = "Scroll Forward" })
vim.keymap.set({"i", "n", "s"}, "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, { silent = true, expr = true, desc = "Scroll Backward" })
-- stylua: ignore end
