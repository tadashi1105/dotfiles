-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "v" }, "<Leader><", ":left<CR>", { desc = "Set indentation to leftmost position" })

map("n", "+", "<C-a>", { desc = "Increment number" })
map("v", "+", "<C-a>gv", { desc = "Increment number in selection" })
map("v", "g+", "g<C-a>gv", { desc = "Sequentially increment numbers in selection" })

map("n", "-", "<C-x>", { desc = "Decrement number" })
map("v", "-", "<C-x>gv", { desc = "Decrement number in selection" })
map("v", "g-", "g<C-x>gv", { desc = "Sequentially decrement numbers in selection" })

map("n", "<Leader>p", '"0p', { desc = "Paste from yank register after cursor" })
map("n", "<Leader>P", '"0P', { desc = "Paste from yank register before cursor" })
map("v", "<Leader>p", '"0p', { desc = "Paste from yank register over selection" })

map("n", "<Leader>o", "o<C-u>", { desc = "Add blank line below, preserving indent" })
map("n", "<Leader>O", "O<C-u>", { desc = "Add blank line above, preserving indent" })

map("n", "<Leader>;,", [[<Cmd>keeppatterns s/\([^,]\)\s*$/\1,/e<CR>]], {
  silent = true,
  desc = "Add comma at the end of the line",
})

map("v", "<Leader>;,", [[:<C-u>keeppatterns '<,'>s/\([^,]\)\s*$/\1,/e<CR>]], {
  silent = true,
  desc = "Add comma at the end of selected lines",
})

map("n", "<Leader>;;", [[<Cmd>keeppatterns s/\([^;]\)\s*$/\1;/e<CR>]], {
  silent = true,
  desc = "Add semicolon at the end of the line",
})

map("v", "<Leader>;;", [[:<C-u>keeppatterns '<,'>s/\([^;]\)\s*$/\1;/e<CR>]], {
  silent = true,
  desc = "Add semicolon at the end of selected lines",
})

-- map("n", "<Leader>;sf", [[<Cmd>keeppatterns s/,\s*/,\r/eg<CR>]], {
--   silent = true,
--   desc = "Insert newline after each comma",
-- })

map("n", "<Leader>;st", function()
  local save_cursor = vim.fn.getpos(".")
  local trailing_spaces = table.concat({
    [[\s\|]], -- Regular space
    [[\%u00A0\|]], -- NO-BREAK SPACE
    [[\%u180E\|]], -- MONGOLIAN VOWEL SEPARATOR
    [[\%u2000\|]], -- EN QUAD
    [[\%u2001\|]], -- EM QUAD
    [[\%u2002\|]], -- EN SPACE
    [[\%u2003\|]], -- EM SPACE
    [[\%u2004\|]], -- THREE-PER-EM SPACE
    [[\%u2005\|]], -- FOUR-PER-EM SPACE
    [[\%u2006\|]], -- SIX-PER-EM SPACE
    [[\%u2007\|]], -- FIGURE SPACE
    [[\%u2008\|]], -- PUNCTUATION SPACE
    [[\%u2009\|]], -- THIN SPACE
    [[\%u200A\|]], -- HAIR SPACE
    [[\%u2028\|]], -- LINE SEPARATOR
    [[\%u2029\|]], -- PARAGRAPH SEPARATOR
    [[\%u202F\|]], -- NARROW NO-BREAK SPACE
    [[\%u205F\|]], -- MEDIUM MATHEMATICAL SPACE
    [[\%u3000]], -- IDEOGRAPHIC SPACE
  })

  vim.cmd(string.format([[ %%s/\%%(%s\)\+$//e ]], trailing_spaces))

  vim.fn.setpos(".", save_cursor)
  print("Trailing whitespace removed")
end, {
  silent = true,
  desc = "Remove trailing whitespace",
})

map("n", "<Leader>;ti", function()
  if vim.bo.expandtab then
    -- Switch to tabs
    vim.bo.expandtab = false
    vim.cmd("retab!")
    print("Indentation changed to tabs")
  else
    -- Switch to spaces
    vim.bo.expandtab = true
    vim.cmd("retab")
    print("Indentation changed to spaces")
  end
end, {
  silent = true,
  desc = "Toggle indentation between tabs and spaces",
})
