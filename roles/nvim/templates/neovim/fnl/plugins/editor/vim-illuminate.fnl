;;; Illuminate
(local {: pack} (require :lib))

(fn config []
  (let [illuminate (require :illuminate)]
    (illuminate.configure {:delay 100
                           :under_cursor true
                           :modes_denylist [:i]
                           :providers [:regex :treesitter]
                           :filetypes_denylist conf.ui-ft})))

(pack :RRethy/vim-illuminate {: config :event [:BufReadPre :BufNewFile]})
