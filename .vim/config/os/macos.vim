"=============================================================================
" MacOS
"=============================================================================

if !has('mac') | finish | endif

" Leave Insert IME Off
autocmd InsertLeave * :call <SID>TurnOffIME()

function! s:TurnOffIME() abort
  let l:imeoff = 'osascript -e "tell application \"System Events\" to key code 41 using {control down, shift down}"'
  execute system(l:imeoff)
endfunction
