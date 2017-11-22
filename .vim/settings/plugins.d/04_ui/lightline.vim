" Lightline
"
Plug 'itchyny/lightline.vim'
autocmd! User lightline call LoadLight()

function LoadLight()
    if !has('gui_running')
        set t_Co=256
    endif

endfunction
