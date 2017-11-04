" Keep undo history across sessions, by storing in file.
"
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

nnoremap <silent> <leader>u :MundoToggle<CR><CR>
"
if has('persistent_undo')
  silent !mkdir ~/.vim/local/backups > /dev/null 2>&1
  set undodir=~/.vim/local/backups
  set undofile
endif
