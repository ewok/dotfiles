" Tmux key navigation
"
if has('gui_running')
else
    call neobundle#append()
    NeoBundle "christoomey/vim-tmux-navigator"
    NeoBundle "benmills/vimux"
    call neobundle#end()

    if has('nvim')
        nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
    endif

    let g:VimuxHeight = "15"
endif
