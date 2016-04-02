" Map ctrl-movement keys to window switching
" nnoremap <C-k> <C-w>k
" nnoremap <C-j> <C-w>j
" nnoremap <C-l> <C-w>l
" nnoremap <C-h> <C-w>h

map gr gT

" Some shortcuts
nnoremap <C-W>t :tabnew<CR>
nnoremap <C-W>C :BD<CR>
nnoremap <F1> :Dash<CR>
inoremap <F1> <ESC>:Dash<CR>a

" Buffers
nnoremap <leader>bc :BD<CR>

" Windows
nnoremap <leader>wc :close<CR>

" Keymap for folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

nnoremap <space> za
vnoremap <space> zf