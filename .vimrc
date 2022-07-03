"=============================================================================
" tadashi1105's .vimrc
"=============================================================================
" Author: tadashi1105
" URL: https://millkeyweb.com
" Source: https://github.com/tadashi1105/dotfiles
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

" Load config files
runtime config/init.vim
runtime config/mappings.vim
runtime config/filetype.vim

" Load config files before plugin
runtime! config/before/plugin/*.rc.vim
if  has('lua') || has('nvim')
  runtime! config/before/plugin/*.rc.lua
endif

" Load plugin
runtime config/plug.vim

" Load config files after plugin
runtime! config/after/plugin/*.rc.vim
if  has('lua') || has('nvim')
  runtime! config/after/plugin/*.rc.lua
endif

runtime! config/os/*.vim
