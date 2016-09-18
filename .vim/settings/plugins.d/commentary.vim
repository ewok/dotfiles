" Toggle comments in code
"
call neobundle#append()
NeoBundle "https://github.com/tpope/vim-commentary.git"
call neobundle#end()

set commentstring=#\ %s
autocmd FileType python  setlocal commentstring=#\ %s
autocmd FileType vim     setlocal commentstring=\"\ %s
autocmd FileType config  setlocal commentstring=#\ %s
autocmd FileType puppet  setlocal commentstring=#\ %s
autocmd FileType rubby   setlocal commentstring=#\ %s
