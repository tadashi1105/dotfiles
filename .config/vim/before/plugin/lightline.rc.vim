"=============================================================================
" itchyny/lightline.vim
" URL: https://github.com/itchyny/lightline.vim
"=============================================================================

" if !exists('g:loaded_lightline') | finish | endif

let g:lightline = {
      \ 'colorscheme': 'nord',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'LightlineFugitiveHead',
      \   'filename': 'LightlineFilename',
			\ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
		  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ }

function! LightlineFugitiveHead()
  let gitbranch = FugitiveHead() !=# '' ? "\ue725 " . FugitiveHead() : ''
  return gitbranch
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' [+]' : ''
  return filename . modified
endfunction