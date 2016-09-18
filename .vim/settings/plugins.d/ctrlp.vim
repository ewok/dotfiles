" Quick jump to buffet/mru/tag
"
call neobundle#append()
NeoBundle "ctrlpvim/ctrlp.vim"
call neobundle#end()

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

nnoremap <silent> <c-p>p :CtrlP<cr>
nnoremap <silent> <c-p><c-p> :CtrlP<cr>
nnoremap <silent> <c-p>t :CtrlPTag<cr>
nnoremap <silent> <c-p><c-t> :CtrlPTag<cr>
nnoremap <silent> <c-p>b :CtrlPBuffer<cr>
nnoremap <silent> <c-p><c-b> :CtrlPBuffer<cr>
