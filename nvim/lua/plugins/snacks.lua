local imgcat = "imgcat"

if vim.fn.executable(imgcat) == 0 then
  return {
    dashboard = {
      preset = {
        header = { "'imgcat' not found: please install it from: https://github.com/danielgatis/imgcat" },
      },
    },
  }
end

Gif = "220764.gif"

local path = vim.fn.stdpath("config") .. "/lua/custom/"
local params = " -silent=true -type=resize -top-offset=1 "
local imgCmd = imgcat .. params .. path .. Gif

local minCol = 135
local paneGap = vim.o.columns > (minCol + 10) and 16 or 3

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      width = 80,
      pane_gap = paneGap,
      sections = {
        {
          section = "header",
          align = "center",
          enabled = function()
            return vim.o.columns < minCol
          end,
        },
        {
          pane = 1,
          {
            enabled = function()
              return vim.o.columns > minCol
            end,
            section = "terminal",
            cmd = imgCmd,
            -- ttl = 0,
            height = 25,
            width = 80,
            padding = 1,
          },
          {
            section = "startup",
            padding = 1,
            enabled = function()
              return vim.o.columns > minCol
            end,
          },
        },
        {
          pane = 2,
          { section = "keys", padding = 1, gap = 1 },
          {
            icon = " ",
            title = "Recent Files",
          },
          {
            section = "recent_files",
            opts = { limit = 3 },
            indent = 2,
            padding = 1,
          },
          {
            icon = " ",
            title = "Projects",
          },
          {
            section = "projects",
            opts = { limit = 3 },
            indent = 2,
            padding = 4,
          },
          { 
            section = "terminal",
            cmd = "colorscript -e six"
          },
          {
            section = "startup",
            padding = 1,
            enabled = function()
              return vim.o.columns < minCol
            end,
          },
        },
      },
    },
  },
}
