(local {: pack : map!} (require :lib))

(local packages ;; Helpers
       [;;; Surround
        (pack :tpope/vim-surround {:config false :event [:InsertEnter]})])

(when conf.options.rainbow_parents
  (table.insert packages (pack :p00f/nvim-ts-rainbow {:config false})))

packages
