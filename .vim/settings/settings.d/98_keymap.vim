" Map ctrl-movement keys to window switching
" nnoremap <C-k> <C-w>k
" nnoremap <C-j> <C-w>j
" nnoremap <C-l> <C-w>l
" nnoremap <C-h> <C-w>h

map gr gT

" Some shortcuts
nnoremap <C-W>t :tabnew<CR>
nnoremap <C-W>C :BD<CR>

" Buffers
nnoremap <leader>bc :BD<CR>

" Windows
nnoremap <leader>wc :close<CR>
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wn :new<CR>
nnoremap <leader>wo :only<CR>
nnoremap <leader>wt :tabnew<CR>
nnoremap <leader>wC :BD<CR>

" Keymap for folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" nnoremap <space> za
" vnoremap <space> zf

imap  <up>    <Nop>
imap  <down>  <Nop>
imap  <left>  <Nop>
imap  <right> <Nop>

nmap  <up>    <Nop>
nmap  <down>  <Nop>
nmap  <left>  <Nop>
nmap  <right> <Nop>

nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $

