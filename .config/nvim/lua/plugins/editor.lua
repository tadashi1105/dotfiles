return {
  {
    "vhyrro/luarocks.nvim",
    lazy = true,
    -- this plugin needs to run before anything else
    priority = 1001,
    opts = {
      rocks = { "magick" },
    },
  },

  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    lazy = true,
    ft = { "markdown", "vimwiki", "norg" },
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
    opts = function(_, opts)
      opts.filesystem.hijack_netrw_behavior = "disabled"
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-file-browser.nvim", "nvim-lua/plenary.nvim" },
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
          local function buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          require("telescope").extensions.file_browser.file_browser({
            path = buffer_dir(),
            cwd = buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = true,
            initial_mode = "normal",
          })
        end,
        desc = "Find Files with File Browser (Current Buffer Dir)",
      },
    },
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      })
      opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
        file_browser = {
          hijack_netrw = true,
          initial_mode = "normal",
        },
      })
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
    end,
  },
}
