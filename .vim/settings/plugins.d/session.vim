" Sessions
"
call neobundle#append()
NeoBundle "xolox/vim-misc"
NeoBundle "xolox/vim-session"
call neobundle#end()

" Autosave and load sessions
let g:session_autosave = 'yes'
"let g:session_autosave_to = 'default'
let g:session_autosave_periodic = 'yes'
let g:session_autoload = 'no'
let g:session_command_aliases = 1
let g:session_persist_font = 0
let g:session_persist_colors = 0
let g:session_lock_enabled = 0

nnoremap <silent> <leader>so :OpenSession<CR>
nnoremap <silent> <leader>ss :SaveSession<CR>
nnoremap <silent> <leader>sq :wa<CR>:CloseSession<CR>:q<CR>
nnoremap <silent> <leader>sx :wa<CR>:CloseSession<CR>
nnoremap <silent> <leader>sk :DeleteSession<CR>

set sessionoptions-=buffers,help
