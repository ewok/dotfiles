function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

set rnu
au InsertEnter * :set nornu
au InsertLeave * :set rnu

