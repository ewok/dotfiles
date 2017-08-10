" Neomake(like Syntastic)
" (neovim only)
"
 if has('nvim')
     Plug 'benekastah/neomake'

     function! NeomakeIfModified()
         if &modified > 0
             Neomake
         endif
     endfunction
     autocmd! BufWritePre * call NeomakeIfModified()
     autocmd! BufEnter * Neomake
 endif
