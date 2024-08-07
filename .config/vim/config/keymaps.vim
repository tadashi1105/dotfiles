"=============================================================================
" Keymaps
"=============================================================================

" Set indentation to leftmost position
noremap <Leader>< :left<CR>

" Keep a selection selected even after indentation
vnoremap > >gv
vnoremap < <gv

" Increment by "+"
nnoremap + <C-a>
vnoremap + <C-a>gv
vnoremap g+ g<C-a>gv

" decrement by "-"
nnoremap - <C-x>
vnoremap - <C-x>gv
vnoremap g- g<C-x>gv

" Escape and Clear hlsearch
inoremap <Esc> <Esc>:nohlsearch<CR><Esc>
nnoremap <Esc> :nohlsearch<CR><Esc>

" Paste from yank register after cursor
nnoremap <Leader>p "0p

" Paste from yank register before cursor
nnoremap <Leader>P "0P

" Paste from yank register over selection
vnoremap <Leader>p "0p

" Change without yanking
noremap <Leader>c "_c

" Change to end of line without yanking
noremap <Leader>C "_C

" Delete without yanking
noremap <Leader>d "_d

" Delete to end of line without yanking
noremap <Leader>D "_D

" Add blank line below, preserving indent
nnoremap <Leader>o o<C-u>

" Add blank line above, preserving indent
nnoremap <Leader>O O<C-u>

" Add comma at the end of the line
nnoremap <silent> <Leader>;, :keeppatterns s/\([^,]\)\s*$/\1,/e<CR>

" Add comma at the end of selected lines
vnoremap <silent> <Leader>;, :<C-u>keeppatterns '<,'>s/\([^,]\)\s*$/\1,/e<CR>

" Add semicolon at the end of the line
nnoremap <silent> <Leader>;; :keeppatterns s/\([^;]\)\s*$/\1;/e<CR>

" Add semicolon at the end of selected lines
vnoremap <silent> <Leader>;; :<C-u>keeppatterns '<,'>s/\([^;]\)\s*$/\1;/e<CR>

" Insert newline after each comma
nnoremap <silent> <Leader>;sf :keeppatterns s/,\s*/,\r/eg<CR>

" Remove trailing whitespace
nnoremap <silent> <Leader>;st :%s/\%(\s\\|\%u00A0\\|\%u180E\\|\%u2000\\|\%u2001\\|\%u2002\\|\%u2003\\|\%u2004\\|\%u2005\\|\%u2006\\|\%u2007\\|\%u2008\\|\%u2009\\|\%u200A\\|\%u2028\\|\%u2029\\|\%u202F\\|\%u205F\\|\%u3000\)\+$//e<CR>:echo "Trailing whitespace removed"<CR>
" nnoremap <silent> <Leader>;st :%s/\%(\s\|\%u00A0\|\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000\)\+$//e<CR>:echo "Trailing whitespace removed"<CR>

" Toggle indentation between tabs and spaces
nnoremap <silent> <Leader>;ti :set expandtab!<CR>:retab!<CR>

" Easily edit .vimrc
nnoremap <Leader>ev :tabnew $MYVIMRC<CR>
nnoremap <Leader>rv :source $MYVIMRC<CR>

nnoremap <Leader>ip :PlugInstall --sync<CR>
