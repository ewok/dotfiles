" Autocomplete code
" (for neovim only)
"
if has('nvim')

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': ['go', 'python', 'd', 'vim', 'bash', 'ansible', 'sh'] }
    autocmd! User deoplete call LoadDeoplete()

    let g:deoplete#enable_at_startup = 1

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

endif
