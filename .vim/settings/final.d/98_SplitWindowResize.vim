" split window resize
if bufwinnr(1)
  map <C-W><C-J> :resize +5<CR>
  map <C-W><C-K> :resize -5<CR>
  map <C-W><C-L> :vertical resize +6<CR>
  map <C-W><C-H> :vertical resize -6<CR>
endif

if has('nvim')
    map <C-W><BS> :vertical resize -6<CR>
endif
" make the current window bigger
"set winheight=5
"set winminheight=5
"set winheight=999

