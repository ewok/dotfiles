if executable("runghc")
  autocmd BufRead,BufNewFile *.hs map <F5> :% w !runghc<CR>
else
  autocmd BufRead,BufNewFile *.hs map <F5> :echo "you need to install ghc first!"<CR>
endif