call neobundle#append()
NeoBundleLazy "simnalamburt/vim-mundo"
call neobundle#end()

augroup load_mundo
  autocmd!
  autocmd InsertEnter * NeoBundleSource vim-mundo
                     \| autocmd! load_mundo
augroup END

nnoremap <silent> <leader>u :MundoToggle<CR><CR>
" nnoremap <leader>u  :NeoBundleSource vim-mundo|unmap <leader>u|nnoremap <silent> <leader>u :MundoToggle<CR><CR>
" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif