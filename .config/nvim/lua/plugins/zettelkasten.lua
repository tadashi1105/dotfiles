return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      -- Required
      "nvim-lua/plenary.nvim",
      -- Option
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    ft = "markdown",
    cmd = {
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianSearch",
      "ObsidianFollowLink",
      "ObsidianBacklinks",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianLinks",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianTomorrow",
      "ObsidianDailies",
      "ObsidianTemplate",
      "ObsidianNewFromTemplate",
      "ObsidianTags",
      "ObsidianExtractNote",
      "ObsidianRename",
      "ObsidianPasteImg",
      "ObsidianToggleCheckbox",
      "ObsidianTOC",
      "ObsidianOpen",
      "ObsidianWorkspace",
    },
    keys = {
      {
        "<leader>Z<Space>",
        function()
          local fzf_lua = require("fzf-lua")

          local obsidian_commands = {
            {
              name = "New Note",
              cmd = "ObsidianNew",
              desc = "`:ObsidianNew [TITLE]` "
                .. "to create a new note. This command has one optional "
                .. "argument: the title of the new note.",
            },
            {
              name = "Quick Switch",
              cmd = "ObsidianQuickSwitch",
              desc = "`:ObsidianQuickSwitch` "
                .. "to quickly switch to (or open) another note in your "
                .. "vault, searching by its name using ripgrep "
                .. "<https://github.com/BurntSushi/ripgrep> with your preferred picker "
                .. "(see |obsidian-plugin-dependencies| below).",
            },
            {
              name = "Search Notes",
              cmd = "ObsidianSearch",
              desc = "`:ObsidianSearch [QUERY]` "
                .. "to search for (or create) notes in your vault using "
                .. "`ripgrep` with your preferred picker.",
            },
            {
              name = "Follow Link",
              cmd = "ObsidianFollowLink",
              desc = "`:ObsidianFollowLink [vsplit|hsplit]` "
                .. "to follow a note reference under the "
                .. "cursor, optionally opening it in a vertical or horizontal split.",
            },
            {
              name = "Backlinks",
              cmd = "ObsidianBacklinks",
              -- stylua: ignore
              desc = "`:ObsidianBacklinks` "
                .. "for getting a picker list of references to the current buffer.",
            },
            {
              name = "Link to Note",
              cmd = "ObsidianLink",
              -- stylua: ignore
              desc = "`:ObsidianLink [QUERY]` "
                .. "to link an inline visual selection of text to a note. "
                .. "This command has one optional argument: a query that will be used to resolve"
                .. "the note by ID, path, or alias. If not given, the selected text will be used as"
                .. "the query.",
            },
            {
              name = "Link to New Note",
              cmd = "ObsidianLinkNew",
              -- stylua: ignore
              desc = "`:ObsidianLinkNew [TITLE]` "
                .. "to create a new note and link it to an inline visual selection of text. "
                .. "This command has one optional argument: the title of the new note. "
                .. "If not given, the selected text will be used as the title.",
            },
            {
              name = "Show Links",
              cmd = "ObsidianLinks",
              -- stylua: ignore
              desc = "`:ObsidianLinks` "
                .. "to collect all links within the current buffer into a picker window.",
            },
            {
              name = "Open Today's Note",
              cmd = "ObsidianToday",
              -- stylua: ignore
              desc = "`:ObsidianToday [OFFSET]` "
                .. "to open/create a new daily note. This command also "
                .. "takes an optional offset in days, e.g. use `:ObsidianToday -1` to go to "
                .. "yesterday’s note. Unlike `:ObsidianYesterday` and `:ObsidianTomorrow` this "
                .. "command does not differentiate between weekdays and weekends.",
            },
            {
              name = "Open Yesterday's Note",
              cmd = "ObsidianYesterday",
              -- stylua: ignore
              desc = "`:ObsidianYesterday` "
                .. "to open/create the daily note for the previous working day.",
            },
            {
              name = "Open Tomorrow's Note",
              cmd = "ObsidianTomorrow",
              -- stylua: ignore
              desc = "`:ObsidianTomorrow` "
                .. "to open/create the daily note for the next working day.",
            },
            {
              name = "Open Daily Notes",
              cmd = "ObsidianDailies",
              -- stylua: ignore
              desc = "`:ObsidianDailies [OFFSET ...]` "
                .. "to open a picker list of daily notes. For example, "
                .. "`:ObsidianDailies -2 1` to list daily notes from 2 days ago until tomorrow.",
            },
            {
              name = "Insert Template",
              cmd = "ObsidianTemplate",
              -- stylua: ignore
              desc = "`:ObsidianTemplate [NAME]` "
                .. "to insert a template from the templates folder, "
                .. "selecting from a list using your preferred picker. See "
                .. '|obsidian-"using-templates"| for more information.',
            },
            {
              name = "New Note from Template",
              cmd = "ObsidianNewFromTemplate",
              -- stylua: ignore
              desc = "`:ObsidianNewFromTemplate [TITLE]` "
                .. "to create a new note from a template in the "
                .. "templates folder. Selecting from a list using your preferred picker. "
                .. "This command has one optional argument: the title of the new note.",
            },
            {
              name = "Search Tags",
              cmd = "ObsidianTags",
              -- stylua: ignore
              desc = "`:ObsidianTags [TAG ...]` "
                .. "for getting a picker list of all occurrences of the given tags.",
            },
            {
              name = "Extract Note",
              cmd = "ObsidianExtractNote",
              -- stylua: ignore
              desc = "`:ObsidianExtractNote [TITLE]` "
                .. "to extract the visually selected text into a new note and link to it.",
            },
            {
              name = "Rename Note",
              cmd = "ObsidianRename",
              -- stylua: ignore
              desc = "`:ObsidianRename [NEWNAME] [--dry-run]` "
                .. "to rename the note of the current "
                .. "buffer or reference under the cursor, updating all backlinks across the vault. "
                .. "Since this command is still relatively new and could potentially write a lot of "
                .. "changes to your vault, I highly recommend committing the current state of your "
                .. "vault (if you’re using version control) before running it, or doing a dry-run "
                .. 'first by appending "–dry-run" to the command, e.g. `:ObsidianRename new-id --dry-run`.',
            },
            {
              name = "Paste Image",
              cmd = "ObsidianPasteImg",
              -- stylua: ignore
              desc = "`:ObsidianPasteImg [IMGNAME]` "
                .. "to paste an image from the clipboard into the "
                .. "note at the cursor position by saving it to the vault and adding a markdown "
                .. "image link. You can configure the default folder to save images to with the "
                .. "`attachments.img_folder` option.",
            },
            {
              name = "Toggle Checkbox",
              cmd = "ObsidianToggleCheckbox",
              -- stylua: ignore
              desc = "`:ObsidianToggleCheckbox` "
                .. "to cycle through checkbox options.",
            },
            {
              name = "Table of Contents",
              cmd = "ObsidianTOC",
              -- stylua: ignore
              desc = "`:ObsidianTOC` "
                .. "to load the table of contents of the current note into a picker list.",
            },
            {
              name = "Open in Obsidian",
              cmd = "ObsidianOpen",
              desc = "`:ObsidianOpen [QUERY]` "
                .. "to open a note in the Obsidian app. This command has "
                .. "one optional argument: a query used to resolve the note to open by ID, path, or "
                .. "alias. If not given, the note corresponding to the current buffer is opened.",
            },
            {
              name = "Switch Workspace",
              cmd = "ObsidianWorkspace",
              -- stylua: ignore
              desc = "`:ObsidianWorkspace [NAME]` "
                .. "to switch to another workspace.",
            },
          }

          local function obsidian_command_palette()
            fzf_lua.fzf_exec(
              vim.tbl_map(function(cmd)
                return cmd.name .. " (" .. cmd.cmd .. "): " .. cmd.desc
              end, obsidian_commands),
              {
                actions = {
                  ["default"] = function(selected)
                    local cmd_name = selected[1]:match("^(.+) %(")
                    for _, cmd in ipairs(obsidian_commands) do
                      if cmd.name == cmd_name then
                        vim.cmd(cmd.cmd)
                        break
                      end
                    end
                  end,
                },
              }
            )
          end

          obsidian_command_palette()
        end,
        desc = "Obsidian Command Palette",
      },
      { "<leader>Zz", "<Cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
      {
        "<leader>Znn",
        function()
          vim.cmd("ObsidianNew")
          vim.defer_fn(function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
            vim.cmd("ObsidianTemplate default-template.md")
          end, 100)
        end,
        desc = "New Note",
      },
      {
        "<leader>Znf",
        function()
          local util = require("obsidian.util")
          local log = require("obsidian.log")

          local title = util.input("Enter title (optional): ", { completion = "file" })

          if not title then
            log.warn("Aborted")
            return
          end

          local fleeting_dir = "zettelkasten/fleeting/"
          vim.cmd("ObsidianNew " .. fleeting_dir .. title)
          vim.defer_fn(function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
            vim.cmd("ObsidianTemplate fleeting-template.md")
          end, 100)
        end,
        desc = "New Fleeting Note",
      },
      {
        "<leader>Znl",
        function()
          local util = require("obsidian.util")
          local log = require("obsidian.log")

          local title = util.input("Enter title (optional): ", { completion = "file" })

          if not title then
            log.warn("Aborted")
            return
          end

          local literature_dir = "zettelkasten/literature/"
          vim.cmd("ObsidianNew " .. literature_dir .. title)
          vim.defer_fn(function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
            vim.cmd("ObsidianTemplate literature-template.md")
          end, 100)
        end,
        desc = "New Literature Note",
      },
      {
        "<leader>Znp",
        function()
          local util = require("obsidian.util")
          local log = require("obsidian.log")

          local title = util.input("Enter title (optional): ", { completion = "file" })

          if not title then
            log.warn("Aborted")
            return
          end

          local permanent_dir = "zettelkasten/permanent/"
          vim.cmd("ObsidianNew " .. permanent_dir .. title)
          vim.defer_fn(function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
            vim.cmd("ObsidianTemplate permanent-template.md")
          end, 100)
        end,
        desc = "New Permanent Note",
      },
      { "<leader>Zs", "<Cmd>ObsidianWorkspace<CR>", desc = "Switch Workspace" },
      { "<leader>Zf", "<Cmd>ObsidianQuickSwitch<CR>", desc = "Find Notes" },
      { "<leader>Zg", "<Cmd>ObsidianSearch<CR>", desc = "Search Notes (Grep)" },
      { "<leader>Zt", "<Cmd>ObsidianToday<CR>", desc = "Goto Today" },
      { "<leader>Zz", "<Cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
      { "<leader>Zb", "<Cmd>ObsidianBacklinks<CR>", desc = "Show Backlinks" },
      { "<leader>Zi", "<Cmd>ObsidianPasteImg<CR>", desc = "Insert Img Link" },
    },
    opts = {
      workspaces = {
        {
          name = "default",
          path = vim.fn.expand("~/Documents/obsidian-vault"),
          strict = true,
        },
        {
          name = "default (enable frontmatter)",
          path = vim.fn.expand("~/Documents/obsidian-vault"),
          strict = true,
          overrides = {
            disable_frontmatter = false,
          },
        },
        -- {
        --   name = "root-dir",
        --   path = function()
        --     return LazyVim.root()
        --   end,
        --   strict = true,
        --   overrides = {
        --     notes_subdir = "docs/notes",
        --     daily_notes = {
        --       folder = "docs/notes",
        --     },
        --     templates = {
        --       folder = vim.fn.expand("~/Documents/obsidian-vault/templates"),
        --     },
        --   },
        -- },
      },
      -- dir = vim.fn.expand("~/Documents/obsidian-vault"),
      notes_subdir = "inbox",
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        -- alias_format = "%B %-d, %Y",
        alias_format = "%Y/%m/%d",
        default_tags = { "daily-notes" },
        template = "daily-template.md",
      },

      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir",

      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        -- local date = os.date("%Y-%m-%d")
        local timestamp = os.date("%Y%m%d%H%M%S")
        -- local timestamp = os.time()
        return tostring(timestamp) .. "_" .. suffix
      end,

      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = true,

      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = {
          id = note.id,
          title = note.title or note:display_name(),
          aliases = note.aliases,
          created = os.date("%Y-%m-%d %H:%M"),
          tags = note.tags,
        }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {
          time24 = function()
            return os.date("%H:%M")
          end,
          time12 = function()
            return os.date("%I:%M %p")
          end,
        },
      },

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
      },
      sort_by = "modified",
      sort_reversed = true,
    },

    -- Specify how to handle attachments.
    attachments = {
      img_folder = "assets",

      ---@return string
      img_name_func = function()
        -- Prefix image names with timestamp.
        return string.format("%s-", os.time())
      end,
    },
  },
}
