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
"let g:session_command_aliases = 1
let g:session_persist_font = 0
"let g:session_persist_colors = 0

nnoremap <silent> <leader>o :OpenSession<CR>
nnoremap <silent> <leader>s :SaveSession<CR>
nnoremap <silent> <leader>qq :wa<CR>:CloseSession<CR>:q<CR>
nnoremap <silent> <leader>qw :wa<CR>:CloseSession<CR>
set sessionoptions-=buffers,blank,curdir,help,
