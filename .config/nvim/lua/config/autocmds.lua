-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

require("util").setup_unicode_space_visualization()

local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

-- Only execute on MacOS
if vim.fn.has("mac") == 1 then
  -- Set up autocmd to call the function on InsertLeave event
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = augroup("mac"),
    pattern = "*",
    callback = function()
      -- Switch to English input
      vim.fn.system([[
        osascript -e 'tell application "System Events" to key code 102'
      ]])
      if vim.v.shell_error ~= 0 then
        vim.api.nvim_err_writeln("Failed to switch input method")
      end
    end,
  })
end
