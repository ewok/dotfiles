" Toggle comments in code
"
Plug 'https://github.com/tpope/vim-commentary.git'

set commentstring=#\ %s
autocmd FileType python  setlocal commentstring=#\ %s
autocmd FileType vim     setlocal commentstring=\"\ %s
autocmd FileType config  setlocal commentstring=#\ %s
autocmd FileType puppet  setlocal commentstring=#\ %s
autocmd FileType rubby   setlocal commentstring=#\ %s
autocmd FileType ansible   setlocal commentstring=#\ %s
