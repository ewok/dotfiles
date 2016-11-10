" Allow to copy/paste between VIM instances
" "copy the current visual selection to ~/.vbuf
vmap <Leader>vy :w! ~/.vim/.vbuf<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>vy :.w! ~/.vim/.vbuf<CR>
" "paste the contents of the buffer file
nmap <Leader>vp :r ~/.vim/.vbuf<CR>
