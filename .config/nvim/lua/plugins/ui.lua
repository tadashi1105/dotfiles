return {
  {
    "b0o/incline.nvim",
    dependencies = { "echasnovski/mini.icons" },
    event = "VeryLazy",
    opts = {
      window = {
        padding = 1,
        margin = { vertical = 0, horizontal = 0 },
      },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local modified = vim.bo[props.buf].modified
        local icon, icon_hl = MiniIcons.get("file", filename)

        return {
          icon and { " ", icon, group = icon_hl } or "",
          " ",
          filename,
          modified and { " [+]", group = "BufferLineModified" } or "",
          " ",
          group = "CursorLine",
        }
      end,
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
