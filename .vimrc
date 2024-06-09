"=============================================================================
" tadashi1105's .vimrc
"=============================================================================

" Init autocmd
autocmd!

" Specify the character encoding used in the script
scriptencoding utf-8

" Note: Skip initialization for vim-tiny or vim-small
if !1 | finish | endif

if has('nvim') && !has('nvim-0.5.0')
  echo '$MYVIMRC is compatible with version 0.5.0 or later.'
  finish
endif

if !has('nvim') && v:version < 801
  echo '$MYVIMRC is compatible with version 8.1 or later.'
  finish
endif

set runtimepath^=~/.config/vim

" Load config files
runtime init.vim
runtime mappings.vim
runtime filetype.vim

" Load config files before plugin
runtime! before/plugin/*.rc.vim
if  has('lua') || has('nvim')
  runtime! before/plugin/*.rc.lua
endif

" Load plugin
runtime plug.vim

" Load config files after plugin
runtime! after/plugin/*.rc.vim
if  has('lua') || has('nvim')
  runtime! after/plugin/*.rc.lua
endif

runtime macos.vim
runtime windows.vim
