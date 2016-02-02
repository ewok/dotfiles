call neobundle#append()
NeoBundle "christoomey/vim-tmux-navigator"
call neobundle#end()

if has('nvim')
    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
endif
