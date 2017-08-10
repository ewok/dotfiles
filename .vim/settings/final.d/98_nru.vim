function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

" nnoremap <leader>sr :call NumberToggle()<cr>

set rnu
au InsertEnter * :set nornu
au InsertLeave * :set rnu
