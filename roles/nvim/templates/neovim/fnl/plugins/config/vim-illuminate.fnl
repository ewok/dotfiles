(fn config []
  (let [illuminate (require :illuminate)]
    (illuminate.configure {:delay 100
                           :under_cursor true
                           :modes_denylist [:i]
                           :providers [:regex :treesitter]
                           :filetypes_denylist conf.ui-ft})))

{: config :event [:BufRead :BufNewFile]}
