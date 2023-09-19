(local {: pack} (require :lib))

[;;; Deal with tabs size
 (pack :tpope/vim-sleuth {:config false :event [:BufReadPre :BufNewFile]})
 ;;; Pretty fold
 (pack :anuvyklack/pretty-fold.nvim
       {:config true :event [:BufReadPre :BufNewFile]})]
