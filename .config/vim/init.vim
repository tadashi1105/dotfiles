"=============================================================================
" Initialize
"=============================================================================

" Enable nocompatible
if &compatible
  set nocompatible
endif

"=============================================================================
" Encoding
"=============================================================================

" Sets the character encoding used inside Vim
set encoding=utf-8

" This is a list of character encodings considered when starting to edit an existing file
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp,sjis

" Automatic recognition of a new line cord
set fileformats=unix,dos,mac

"=============================================================================
" Edit
"=============================================================================

filetype plugin indent on

" Smart insert tab setting
set smarttab

" Exchange tab to spaces
set expandtab

" Number of spaces that <TAB> corresponds to
set tabstop=2
set shiftwidth=2

" Round indent by shiftwidth
set shiftround

" Automatic indentation
set autoindent

" Enable smart indent
set smartindent

" Automatic indentation of C program files
set cindent

" Use clipboard register
if has('unnamedplus')
  set clipboard^=unnamedplus
else
  set clipboard^=unnamed
endif

" Enable backspace delete indent and newline
set backspace=indent,eol,start

" Highlight parenthesis
set showmatch

" Set the display time of the corresponding parentheses to 1
set matchtime=1

" Display another buffer when current buffer isn't saved
set hidden

" Keymapping timeout
set timeout timeoutlen=3000 ttimeoutlen=100

if exists('&ambiwidth')
  " Ensure that the cursor position is not displaced by the letters □ and ○
  "set ambiwidth=double
endif

" If option "m" is specified, when formatting lines, line breaks are inserted even if they are multibyte characters.
" If option "M" is specified, when concatenating lines, do not insert spaces even if they are multibyte characters.
set formatoptions+=mM

" Backup
set nobackup

" Swap
set swapfile

" Undo
set undofile

"=============================================================================
" Search
"=============================================================================

" Ignore the case of normal letters
set ignorecase

" If the search pattern contains upper case characters, override ignorecase option
set smartcase

" Enable incremental search
set incsearch

" Highlight search patterns, support reloading
set hlsearch

"=============================================================================
" View
"=============================================================================

" Always display statusline
set laststatus=2

" Height of command line
set cmdheight=2

" Display the command being entered in the status
set showcmd

" Show title
set title

" Wrap and display long lines
set wrap

" Turn down a long line appointed in 'breakat'
set linebreak
set showbreak=\\\  " Set whitespace
set breakindent

" Wrap conditions
set whichwrap+=<,>,[,],~

" Disable bell
set belloff=all
set visualbell

" Use enhanced command line completion when
set wildmenu
set wildmode=list:longest,full

" Increase history amount
set history=200

" When a line is long, do not omit it in @
set display=lastline

" Show Ruler
set ruler

" Show line number
set number
" set relativenumber

" Highlight cursor line
set cursorline

set background=dark
