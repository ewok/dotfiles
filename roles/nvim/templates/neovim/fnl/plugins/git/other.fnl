(local {: pack} (require :lib))

[(pack :tpope/vim-rhubarb {:config false :event [:BufReadPre :BufNewFile]})
 (pack :rbong/vim-flog {:config false})]
