" Neomake(like Syntastic)
" (neovim only)
"
 if has('nvim')
     call neobundle#append()
     NeoBundle "benekastah/neomake"
     call neobundle#end()

     function! NeomakeIfModified()
         if &modified > 0
             Neomake
         endif
     endfunction
     autocmd! BufWritePre * call NeomakeIfModified()
     autocmd! BufEnter * Neomake
 endif
