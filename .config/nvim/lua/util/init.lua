local M = {}

local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

local unicode_spaces = table.concat({
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
  [[\%u205F\|]], -- MEDIUM MATHEMATICAL SPACE
  [[\%u3000]], -- IDEOGRAPHIC SPACE
})

local function define_unicode_space_syntax()
  vim.cmd(string.format([[syntax match UnicodeSpace /%s/]], unicode_spaces))
  vim.cmd([[highlight default UnicodeSpace term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red]])
end

function M.setup_unicode_space_visualization()
  define_unicode_space_syntax()

  vim.api.nvim_create_autocmd({ "BufWinEnter", "ColorScheme" }, {
    group = augroup("highlight"),
    pattern = "*",
    callback = function()
      define_unicode_space_syntax()
    end,
  })

  vim.keymap.set("n", "<Leader>;tl", function()
    vim.opt.list = not vim.o.list
    vim.cmd("syntax clear UnicodeSpace")
    if vim.o.list then
      define_unicode_space_syntax()
    end
  end, {
    silent = true,
    desc = "Toggle list mode and highlight Unicode white space characters",
  })
end

return M
