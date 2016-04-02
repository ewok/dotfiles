call neobundle#append()
NeoBundle 'fatih/vim-go'
NeoBundle 'garyburd/go-explorer'
NeoBundle "benmills/vimux-golang"
call neobundle#end()

" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

let g:go_auto_type_info = 1
" let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"

" Shortcuts
au FileType go nnoremap <F5><F5> :w<CR>:GoImports<CR>:GolangRun<CR>
" au FileType go nnoremap <F5><F5> :w<CR>:GoImports<CR>:GoRun<CR>
au FileType go nnoremap <F5><F6> :w<CR>:GoImports<CR>:GolangTestCurrentPackage<CR>
" au FileType go nnoremap <F5><F6> :w<CR>:GoImports<CR>:GoTest<CR>
au FileType go nnoremap <F5><F7> :w<CR>:GoImports<CR>:GoBuild<CR>
au FileType go nnoremap <F5><F8> :w<CR>:GoImports<CR>:GoCoverage<CR>

" Fix syntastic lags
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" au FileType go nmap <F5> <Plug>(go-run)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap K <Plug>(go-doc)
au FileType go nmap <Leader>i <Plug>(go-info)

 let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
