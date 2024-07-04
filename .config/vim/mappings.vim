"=============================================================================
" Mappings
"=============================================================================

" Use <Leader> in global plugin. Use ',' instead of '\'
let g:mapleader = "\<Space>"

" Allow moving when wrapping strings
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Set indentation to (default 0)
nnoremap 0< :left<CR>
vnoremap 0< :left<CR>

" Replace the whole
noremap <Leader>s :<C-u>%s/

" Replace '\n ' with ' '
vnoremap <Leader>ss :s/\v\n\s*/ /g<CR>:nohlsearch<CR>:match<CR>

" Replace ', ' with ',\n'
vnoremap <Leader>sr :s/\v,\s*/,\n/g<CR>:nohlsearch<CR>:match<CR>

" Repeatedly paste the latest Yank character
vnoremap <Leader>p "0p

" Yank to the end with Y
noremap Y y$

" Using emacs key bindings
inoremap <silent> <C-a> <C-o>:call s:MoveCursorToHome()<CR>
cnoremap <C-a> <Home>
inoremap <C-b> <Left>
cnoremap <C-b> <Left>
inoremap <C-d> <Del>
cnoremap <C-d> <Del>
inoremap <C-e> <End>
cnoremap <C-e> <End>
inoremap <C-f> <Right>
cnoremap <C-f> <Right>
inoremap <C-h> <Backspace>
cnoremap <C-h> <Backspace>
inoremap <C-k> <C-o>D
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Add ";" at the end of a line
inoremap <expr>,; <SID>IsEndOfLine(';') ? '<C-o>$' : '<C-o>$;'
nnoremap <expr>,; <SID>IsEndOfLine(';') ? '$' : '$a;<Esc>'

" Add "," at the end of a line
inoremap <expr>,, <SID>IsEndOfLine(',') ? '<C-o>$' : '<C-o>$,'
nnoremap <expr>,, <SID>IsEndOfLine(',') ? '$' : '$a,<Esc>'

" Add blank line
nnoremap <silent> <CR> :<C-u>call append(expand('.'), '')<CR>j

" Toggle highlight search
noremap <silent> <Esc><Esc> :<C-u>set hlsearch!<CR>

" Indent toggle between whitespace and tabs
noremap <Leader>ti :<C-u>set expandtab!<CR>:retab!<CR>

" Quick quit
autocmd FileType help nnoremap <buffer> q :q<CR>
autocmd FileType qf nnoremap <buffer> q :cclose<CR>

" Easily edit .vimrc
nnoremap <Leader>ev :tabnew $MYVIMRC<CR>
nnoremap <Leader>rv :source $MYVIMRC<CR>

" Increment and decrement with "+" and "-"
nnoremap + <C-a>
nnoremap - <C-x>

" No deselection after increment or decrement.
vnoremap <C-a> <C-a>gv
vnoremap g<C-a> g<C-a>gv
vnoremap <C-x> <C-x>gv
vnoremap g<C-x> g<C-x>gv

" Keep a selection selected even after indentation
vnoremap > >gv
vnoremap < <gv

" Toggle visibility of invisible characters
noremap <Leader>ll :<C-u>call <SID>ToggleInvisibleCharacters()<CR>

" Specify the display format of invisible characters
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
highlight default link UnicodeSpaces Error

if has('nvim')
  nnoremap <Leader>ip :PlugInstall --sync <Bar> source $MYVIMRC<CR>
else
  nnoremap <Leader>ip :PlugInstall --sync<CR>
endif

"=============================================================================
" Function
"=============================================================================

" Check if the character at the end of the line is the specified character
function! s:IsEndOfLine(char) abort "{{{
  return getline('.')[col('$')-2] == a:char
endfunction "}}}

" <C-a> or <C-e> to move
function! s:MoveCursorToHome() abort
  let l:c = col('.')
  exec 'normal! ^'
  if col('.') == l:c
    exec 'normal! 0'
  endif
endfunction

function! s:ToggleInvisibleCharacters() abort
  set list! list?
  syntax clear UnicodeSpaces
  if &list
    syntax match UnicodeSpaces /\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000/
  endif
endfunction
