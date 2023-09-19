(local {: pack} (require :lib))

[(pack :chaoren/vim-wordmotion {:config false :event [:BufReadPre :BufNewFile]})
 (pack :tpope/vim-repeat {:config false :event [:BufReadPre :BufNewFile]})]
