(local {: pack} (require :lib))

[;; Nice UI
 (pack :stevearc/dressing.nvim {:config false})
 ;; Winbar
 (pack :SmiteshP/nvim-navic {:config false :event [:BufReadPre :BufNewFile]})
 ;; Buferline
 (pack :ewok/scope.nvim {:config true :event [:BufReadPre :BufNewFile]})
 ;; TODO: To test
 ; https://github.com/folke/noice.nvim
 ]
