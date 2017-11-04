" Tmux key navigation
"
if has('gui_running')
else
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'benmills/vimux'

    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

    let g:tmux_navigator_save_on_switch = 2
    let g:tmux_navigator_disable_when_zoomed = 1

    let g:VimuxHeight = "15"
endif
