-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings:append({ "euc-jp", "cp932", "iso-2022-jp", "sjis" })
opt.smarttab = true
opt.autoindent = true
opt.hidden = true
opt.formatoptions:append({ m = true, M = true })
opt.inccommand = "split"
opt.path:append({ "**" })
opt.title = true
opt.breakindent = true

opt.whichwrap:append({
  ["<"] = true,
  [">"] = true,
  ["["] = true,
  ["]"] = true,
})

-- opt.listchars = {
--   space = "･",
--   eol = "↴",
--   tab = "▸ ",
--   trail = "•",
--   extends = "›",
--   precedes = "‹",
--   nbsp = "⦸",
-- }
