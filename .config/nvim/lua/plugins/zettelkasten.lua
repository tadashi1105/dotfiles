return {
  -- {
  --   "renerocksai/telekasten.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   lazy = true,
  --   ft = "markdown",
  --   cmd = "Telekasten",
  --   keys = {
  --     { "<leader>Z<Space>", "<Cmd>Telekasten panel<CR>", desc = "Telekasten Launch Panel" },
  --     { "<leader>Zz", "<Cmd>Telekasten follow_link<CR>", desc = "Follow Link" },
  --     { "<leader>Znn", "<Cmd>Telekasten new_note<CR>", desc = "New Note" },
  --     { "<leader>Znf", "<Cmd>Telekasten new_note<CR>fleeting/", desc = "New Fleeting Note" },
  --     { "<leader>Znl", "<Cmd>Telekasten new_note<CR>literature/", desc = "New Literature Note" },
  --     { "<leader>Znp", "<Cmd>Telekasten new_note<CR>permanent/", desc = "New Permanent Note" },
  --     { "<leader>Zs", "<Cmd>Telekasten switch_vault<CR>", desc = "Switch Vault" },
  --     { "<leader>Zf", "<Cmd>Telekasten find_notes<CR>", desc = "Find Notes" },
  --     { "<leader>Zg", "<Cmd>Telekasten search_notes<CR>", desc = "Search Notes (Grep)" },
  --     { "<leader>Zt", "<Cmd>Telekasten goto_today<CR>", desc = "Goto Today" },
  --     { "<leader>ZT", "<Cmd>Telekasten goto_thisweek<CR>", desc = "Goto This Week" },
  --     { "<leader>Zz", "<Cmd>Telekasten follow_link<CR>", desc = "Follow Link" },
  --     { "<leader>Zb", "<Cmd>Telekasten show_backlinks<CR>", desc = "Show Backlinks" },
  --     { "<leader>Zi", "<Cmd>Telekasten insert_img_link<CR>", desc = "Insert Img Link" },
  --     { "[[", "<Cmd>Telekasten insert_link<CR>", mode = "i", ft = "markdown", desc = "Insert Link" },
  --   },
  --   opts = function()
  --     local defaults_cfg = {
  --       auto_set_filetype = false,
  --       templates = vim.fn.expand("~/Documents/notes/templates"),
  --       filename_space_subst = "-",
  --       tag_notation = "yaml-bare",
  --       -- command_palette_theme = "dropdown",
  --       -- show_tags_theme = "dropdown",
  --       -- debug = true,
  --     }
  --
  --     return {
  --       vaults = {
  --         default = vim.tbl_deep_extend("force", defaults_cfg or {}, {
  --           home = vim.fn.expand("~/Documents/notes/inbox/notes"),
  --           dailies = vim.fn.expand("~/Documents/notes/inbox/notes/dailies"),
  --           weeklies = vim.fn.expand("~/Documents/notes/inbox/notes/weeklies"),
  --           image_subdir = vim.fn.expand("~/Documents/notes/inbox/assets/images"),
  --         }),
  --         til = vim.tbl_deep_extend("force", defaults_cfg or {}, {
  --           home = vim.fn.expand("~/Documents/notes/til/notes"),
  --           dailies = vim.fn.expand("~/Documents/notes/til/notes/dailies"),
  --           weeklies = vim.fn.expand("~/Documents/notes/til/notes/weeklies"),
  --           image_subdir = vim.fn.expand("~/Documents/notes/til/assets/images"),
  --         }),
  --       },
  --     }
  --   end,
  -- },

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
          local pickers = require("telescope.pickers")
          local finders = require("telescope.finders")
          local conf = require("telescope.config").values
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")
          local entry_display = require("telescope.pickers.entry_display")
          local make_entry = require("telescope.make_entry")

          -- List of obsidian.nvim commands
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

          local obsidian_picker = function(opts)
            opts = opts or {}

            local displayer = entry_display.create({
              separator = "▏",
              items = {
                { width = 25 },
                { width = 25 },
                { remaining = true },
              },
            })

            local make_display = function(entry)
              return displayer({
                { entry.name, "TelescopeResultsIdentifier" },
                { entry.cmd },
                { entry.desc },
              })
            end

            local entry_maker = function(entry)
              return make_entry.set_default_entry_mt({
                value = entry,
                display = make_display,
                ordinal = entry.name .. " " .. entry.cmd,
                name = entry.name,
                cmd = entry.cmd,
                desc = entry.desc,
              })
            end

            pickers
              .new(opts, {
                prompt_title = "Obsidian Commands",
                finder = finders.new_table({
                  results = obsidian_commands,
                  entry_maker = entry_maker,
                }),
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(prompt_bufnr, map)
                  actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.cmd(selection.cmd)
                  end)
                  return true
                end,
              })
              :find()
          end

          obsidian_picker()
        end,
        desc = "Obsidian Command Palette",
      },
      { "<leader>Zz", "<Cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
      { "<leader>Znn", "<Cmd>ObsidianNew<CR>", desc = "New Note" },
      {
        "<leader>Znf",
        function()
          local client = require("obsidian").get_client()
          local util = require("obsidian.util")
          local log = require("obsidian.log")

          local title = util.input("Enter title (optional): ", { completion = "file" })

          if not title then
            log.warn("Aborted")
            return
          end

          local notes_subdir = client.opts.notes_subdir
          local fleeting_dir = notes_subdir and (notes_subdir .. "/fleeting/") or "fleeting/"

          vim.cmd("ObsidianNew " .. fleeting_dir .. title)
        end,
        desc = "New Fleeting Note",
      },
      {
        "<leader>Znl",
        function()
          local client = require("obsidian").get_client()
          local util = require("obsidian.util")
          local log = require("obsidian.log")

          local title = util.input("Enter title (optional): ", { completion = "file" })

          if not title then
            log.warn("Aborted")
            return
          end

          local notes_subdir = client.opts.notes_subdir
          local literature_dir = notes_subdir and (notes_subdir .. "/literature/") or "literature/"

          vim.cmd("ObsidianNew " .. literature_dir .. title)
        end,
        desc = "New Literature Note",
      },
      {
        "<leader>Znp",
        function()
          local client = require("obsidian").get_client()
          local util = require("obsidian.util")
          local log = require("obsidian.log")

          local title = util.input("Enter title (optional): ", { completion = "file" })

          if not title then
            log.warn("Aborted")
            return
          end

          local notes_subdir = client.opts.notes_subdir
          local permanent_dir = notes_subdir and (notes_subdir .. "/permanent/") or "permanent/"

          vim.cmd("ObsidianNew " .. permanent_dir .. title)
        end,
        desc = "New Permanent Note",
      },
      { "<leader>Zs", "<Cmd>ObsidianWorkspace<CR>", desc = "Switch Workspace" },
      { "<leader>Zf", "<Cmd>ObsidianQuickSwitch<CR>", desc = "Find Notes" },
      { "<leader>Zg", "<Cmd>ObsidianSearch<CR>", desc = "Search Notes (Grep)" },
      { "<leader>Zt", "<Cmd>ObsidianToday<CR>", desc = "Goto Today" },
      -- { "<leader>ZT", "<Cmd><CR>", desc = "Goto This Week" },
      { "<leader>Zz", "<Cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
      { "<leader>Zb", "<Cmd>ObsidianBacklinks<CR>", desc = "Show Backlinks" },
      { "<leader>Zi", "<Cmd>ObsidianPasteImg<CR>", desc = "Insert Img Link" },
    },
    opts = {
      workspaces = {
        {
          name = "default",
          path = vim.fn.expand("~/Documents/Obsidian Vault"),
          strict = true,
          overrides = {
            notes_subdir = "inbox/notes",
            daily_notes = {
              folder = "inbox/notes/dailies",
              date_format = "%Y-%m-%d",
              alias_format = "%B %-d, %Y",
              default_tags = { "daily-notes" },
              template = nil,
            },
            templates = {
              folder = "templates",
              -- substitutions = {},
            },
          },
        },
        {
          name = "default (disable frontmatter)",
          path = vim.fn.expand("~/Documents/Obsidian Vault"),
          strict = true,
          overrides = {
            notes_subdir = "inbox/notes",
            daily_notes = {
              folder = "inbox/notes/dailies",
              date_format = "%Y-%m-%d",
              alias_format = "%B %-d, %Y",
              default_tags = { "daily-notes" },
              template = nil,
            },
            templates = {
              folder = "templates",
              -- substitutions = {},
            },
            disable_frontmatter = true,
          },
        },
        {
          name = "personal",
          path = vim.fn.expand("~/Documents/Obsidian Vault/personal"),
          strict = true,
          overrides = {
            notes_subdir = "notes",
            templates = {
              folder = "../templates",
              -- substitutions = {},
            },
          },
        },
        {
          name = "work",
          path = vim.fn.expand("~/Documents/Obsidian Vault/work"),
          strict = true,
          overrides = {
            notes_subdir = "notes",
            templates = {
              folder = "../templates",
              -- substitutions = {},
            },
          },
        },
        {
          name = "til",
          path = vim.fn.expand("~/Documents/Obsidian Vault/til"),
          strict = true,
          overrides = {
            notes_subdir = "notes",
            templates = {
              folder = "../templates",
              -- substitutions = {},
            },
          },
        },
        {
          name = "qiita",
          path = vim.fn.expand("~/Documents/Obsidian Vault/qiita-content"),
          strict = true,
          overrides = {
            notes_subdir = "public",
            templates = {
              folder = "../templates",
              -- substitutions = {},
            },
            disable_frontmatter = true,
          },
        },
        {
          name = "zenn",
          path = vim.fn.expand("~/Documents/Obsidian Vault/zenn-content"),
          strict = true,
          overrides = {
            notes_subdir = "articles",
            templates = {
              folder = "../templates",
              -- substitutions = {},
            },
            disable_frontmatter = true,
          },
        },
      },
      -- dir = vim.fn.expand("~/Documents/Obsidian Vault"),
      notes_subdir = "notes",
      daily_notes = {
        folder = "notes/dailies",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily-notes" },
        template = nil,
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
        local timestamp = os.time()
        return tostring(timestamp) .. "-" .. suffix
      end,

      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
          title = note.title or note:display_name(),
          created = os.date("%Y-%m-%d %H:%M"),
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
      img_folder = "assets/images",

      ---@return string
      img_name_func = function()
        -- Prefix image names with timestamp.
        return string.format("%s-", os.time())
      end,
    },
  },
}
