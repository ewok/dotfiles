" VIM
"
if has('nvim')
    Plug 'Shougo/neco-vim', { 'for': 'vim' }
    autocmd! User neco-vim call LoadNeco()
    function! LoadNeco()
        au FileType vim nmap <buffer> <leader>rr :source %<CR>:echon "script reloaded!"<CR>
    endfunction
endif
