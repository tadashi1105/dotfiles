"=============================================================================
" MacOS
"=============================================================================

if !has('mac') | finish | endif

" Autocommand to call the function when leaving insert mode
augroup change_input_method
  autocmd!
  autocmd InsertLeave * call s:switch_to_english()
augroup END

" Function to switch IME to English when leaving insert mode
function! s:switch_to_english()
  try
    silent execute '!osascript -e ''tell application "System Events" to key code 102'''
  catch
    echoerr 'Failed to switch input method'
  endtry
endfunction
