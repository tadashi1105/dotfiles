"=============================================================================
" Options
"=============================================================================

set nocompatible

set encoding=utf-8
set fileencoding=utf-8
set fileencodings+=utf-8,euc-jp,cp932,iso-2022-jp,sjis

set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
set autoindent
set smartindent

set clipboard^=unnamedplus,unnamed
set backspace=indent,eol,start
set hidden

" If option "m" is specified, when formatting lines, line breaks are inserted even if they are multibyte characters.
" If option "M" is specified, when concatenating lines, do not insert spaces even if they are multibyte characters.
set formatoptions+=mM

set nobackup
if !isdirectory($HOME."/.local/state/vim")
    call mkdir($HOME."/.local/state/vim", "", 0770)
endif
if !isdirectory($HOME."/.local/state/vim/undo")
    call mkdir($HOME."/.local/state/vim/undo", "", 0700)
endif
set undodir=~/.local/state/vim/undo
set undofile

set ignorecase
set smartcase
set incsearch
set hlsearch

set laststatus=2
set cmdheight=1
set showcmd
set title

set linebreak
set breakindent
set whichwrap+=<,>,[,]

set belloff=all
set history=10000
set display=lastline

set ruler
set number
set cursorline

set splitright
set splitbelow
set background=dark

set listchars=space:･,eol:↴,tab:▸-,trail:•,extends:›,precedes:‹,nbsp:⦸

set ttimeout
set ttimeoutlen=1
set ttyfast

let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" Use `<Space>` for `<Leader>`.
let g:mapleader = "\<Space>"
