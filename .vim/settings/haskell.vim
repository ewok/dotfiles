call neobundle#append()
NeoBundle "eagletmt/ghcmod-vim"
NeoBundle "bitc/vim-hdevtools"
NeoBundle "Twinside/vim-hoogle"
NeoBundle "eagletmt/neco-ghc"
NeoBundle "neovimhaskell/haskell-vim"
" NeoBundle "nbouscal/vim-stylish-haskell"
" Useless
" NeoBundle "enomsg/vim-haskellConcealPlus"
" Experiment
" NeoBundle "ervandew/supertab"
call neobundle#end()

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

