" Syntax checking
"
if has('nvim')
else
    " Plug 'scrooloose/syntastic'
    Plug 'w0rp/ale'

    let s:puppet_new = "puppet-3.4.3"
    " let g:syntastic_error_symbol = emoji#for('no_entry')
    " let g:syntastic_warning_symbol = emoji#for('warning')
    let g:syntastic_enable_highlighting = 1
    " let g:syntastic_python_checkers=['python']
    let g:syntastic_python_checkers=['flake8']
    " let g:syntastic_python_flake8_args=''
    let g:syntastic_python_flake8_args='--ignore=E501'

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    map <F6> :w<CR>:Error<CR>
endif
