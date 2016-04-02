if has('nvim')
else
    call neobundle#append()
    NeoBundle "https://github.com/airblade/vim-gitgutter"
    call neobundle#end()

    silent! if emoji#available()
    let g:gitgutter_sign_added = emoji#for('seedling')
    let g:gitgutter_sign_modified = emoji#for('paw_prints')
    let g:gitgutter_sign_removed = emoji#for('fire')
    let g:gitgutter_sign_modified_removed = emoji#for('collision')
    endif

    let g:gitgutter_map_keys = 0

    nmap <Leader>gt <Plug>GitGutterStageHunk
    nmap <Leader>gu <Plug>GitGutterRevertHunk

    nmap [c <Plug>GitGutterPrevHunk
    nmap ]c <Plug>GitGutterNextHunk
endif