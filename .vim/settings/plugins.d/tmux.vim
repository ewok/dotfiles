" Tmux key navigation
"
if has('gui_running')
else
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'benmills/vimux'

    if has('nvim')
        nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
    endif

    let g:VimuxHeight = "15"
endif
