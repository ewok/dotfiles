" Quick jump to buffet/mru/tag
"
call neobundle#append()
NeoBundle "ctrlpvim/ctrlp.vim"
call neobundle#end()

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

nnoremap <silent> <leader>pp :CtrlP<cr>
nnoremap <silent> <leader>pt :CtrlPTag<cr>
nnoremap <silent> <leader>pb :CtrlPBuffer<cr>

nnoremap <silent> <c-p><c-p> <nop>
nnoremap <silent> <c-p><c-t> <nop>
nnoremap <silent> <c-p><c-b> <nop>

" Use regex instead of mru
let g:ctrlp_regexp = 1
