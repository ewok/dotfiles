" Map ctrl-movement keys to window switching
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

map gr gT

" Some shortcuts
map <UP> <NOP>
map <DOWN> <NOP>
map <LEFT> <NOP>
map <RIGHT> <NOP>
inoremap <UP> <NOP>
inoremap <DOWN> <NOP>
inoremap <LEFT> <NOP>
inoremap <RIGHT> <NOP>
nnoremap <C-W>t :tabnew<CR>
nnoremap <C-W>C :bd<CR>
nnoremap <F1> :Dash<CR>
inoremap <F1> <ESC>:Dash<CR>a

" Keymap for folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

nnoremap <space> za
vnoremap <space> zf