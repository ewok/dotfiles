" Golang support
"
call neobundle#append()
NeoBundle 'fatih/vim-go'
NeoBundle 'garyburd/go-explorer'
NeoBundle "benmills/vimux-golang"
if has('nvim')
    NeoBundle 'zchee/deoplete-go', {'build': {'unix': 'make'}}
endif
call neobundle#end()

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
au FileType go nnoremap <silent> <leader>rr :w<CR>:GoImports<CR>:GoRun<CR>
au FileType go nnoremap <silent> <leader>rt :w<CR>:GoImports<CR>:GoTest<CR>
au FileType go nnoremap <silent> <leader>rb :w<CR>:GoImports<CR>:GoBuild<CR>
au FileType go nnoremap <silent> <leader>rc :w<CR>:GoImports<CR>:GoCoverageToggle<CR>

" Fix syntastic lags
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" au FileType go nmap <F5> <Plug>(go-run)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap K <Plug>(go-doc)
au FileType go nmap <Leader>di <Plug>(go-info)

