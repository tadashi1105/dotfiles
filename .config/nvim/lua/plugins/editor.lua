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
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "3rd/image.nvim" },
    opts = function(_, opts)
      opts.filesystem.hijack_netrw_behavior = "disabled"
    end,
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader>fp",
        function()
          require("fzf-lua").files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fC",
        function()
          require("fzf-lua").files({ cwd = os.getenv("HOME") .. "/.config" })
        end,
        desc = "Find Config File (~/.config Dir)",
      },
      {
        "<leader>fB",
        function()
          local function buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          require("fzf-lua").files({
            cwd = buffer_dir(),
          })
        end,
        desc = "Find Files with File Browser (Current Buffer Dir)",
      },
    },
  },
}
