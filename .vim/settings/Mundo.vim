call neobundle#append()
NeoBundle "simnalamburt/vim-mundo"
call neobundle#end()

nnoremap <silent> <leader>u :GundoToggle<CR><CR>
" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif