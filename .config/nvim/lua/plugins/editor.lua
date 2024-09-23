return {
  {
    "vhyrro/luarocks.nvim",
    -- this plugin needs to run before anything else
    priority = 1001,
    opts = {
      rocks = { "magick" },
    },
  },

  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          -- markdown extensions (ie. quarto) can go here
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      kitty_method = "normal",

      -- toggles images when windows are overlapped
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

      -- auto show/hide images when the editor gains/looses focus
      editor_only_render_when_focused = false,

      -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      tmux_show_only_in_active_window = true,

      -- render image files as images when opened
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
    -- config = true,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "3rd/image.nvim" },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fC",
        function()
          require("telescope.builtin").find_files({ cwd = os.getenv("HOME") .. "/.config" })
        end,
        desc = "Find Config File (~/.config Dir)",
      },
      {
        "<leader>fB",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
        end,
        desc = "Find Files (Current Buffer Dir)",
      },
    },
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      })
    end,
  },
}
