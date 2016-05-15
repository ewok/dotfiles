" for macvim install with env
" PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/local/bin/ bash install.sh --clang-completer
if has('nvim')
else
    if has('gui_running')
    else

    call neobundle#append()
    NeoBundleLazy "Valloric/YouCompleteMe"
    call neobundle#end()
    augroup load_us_ycm
      autocmd!
      " autocmd InsertEnter * NeoBundleSource YouCompleteMe
      autocmd FileType puppet,python,go,ruby,lua,haskell,java,c,d NeoBundleSource YouCompleteMe
                         \| call youcompleteme#Enable() | autocmd! load_us_ycm
    augroup END

    let g:ycm_semantic_triggers =  {
                \   'c' : ['->', '.'],
                \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
                \             're!\[.*\]\s'],
                \   'ocaml' : ['.', '#'],
                \   'cpp,objcpp' : ['->', '.', '::'],
                \   'perl' : ['->'],
                \   'php' : ['->', '::'],
                \   'cs,java,javascript,typescript,d,perl6,scala,vb,elixir,go' : ['.'],
                \   'haskell' : ['.', ':: '],
                \   'python' : ['.'],
                \   'ruby' : ['.', '::'],
                \   'lua' : ['.', ':'],
                \   'erlang' : [':'],
                \ }
    " let g:ycm_semantic_triggers = {'haskell' : ['.']}
    " let g:ycm_cache_omnifunc = 0
    let g:ycm_collect_identifiers_from_tags_files = 1

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    " Close popup by <Space>.
    inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
    "
    endif
endif
