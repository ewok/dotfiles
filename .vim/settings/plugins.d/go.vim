" Golang support
"
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
autocmd! User vim-go call LoadGo()
" Plug 'garyburd/go-explorer'
Plug 'benmills/vimux-golang', { 'for': 'go' }

if has('nvim')
    Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
endif

Plug 'jodosha/vim-godebug', { 'for': 'go' }

function! LoadGo()

    let $GOPATH = $HOME . '/share/gopath/' . fnamemodify(getcwd(), ':t')
    let $GOBIN = $HOME . '/.local/bin'

    if has('nvim')
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_interfaces = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
    endif

    " let g:go_auto_type_info = 1
    let g:go_auto_sameids = 1
    " let g:go_fmt_autosave = 0
    let g:go_fmt_command = "goimports"

    " Shortcuts
    au FileType go nnoremap <buffer> <silent> <leader>rr :w<CR>:GoImports<CR>:silent GoRun<CR>
    au FileType go nnoremap <buffer> <silent> <leader>rt :w<CR>:GoImports<CR>:GoTest<CR>
    au FileType go nnoremap <buffer> <silent> <leader>rb :w<CR>:GoImports<CR>:GoBuild<CR>
    au FileType go nnoremap <buffer> <silent> <leader>rc :w<CR>:GoImports<CR>:GoCoverageToggle<CR>

    " Fix syntastic lags
    " let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    " let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

    " au FileType go nmap <F5> <Plug>(go-run)

    au FileType go nmap <buffer> <Leader>ds <Plug>(go-def-split)
    au FileType go nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
    au FileType go nmap <buffer> <Leader>dt <Plug>(go-def-tab)
    au FileType go nmap <buffer> K <Plug>(go-doc)
    au FileType go nmap <buffer> <Leader>di <Plug>(go-info)

endfunction
