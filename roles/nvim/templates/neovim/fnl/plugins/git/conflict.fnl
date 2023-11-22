(local {: pack} (require :lib))

(fn config []
  (let [git (require :git-conflict)]
    (git.setup {:default_mappings {:ours :<leader>gco
                                   :theirs :<leader>gct
                                   :none :<leader>gcn
                                   :both :<leader>gcb
                                   :next "]x"
                                   :prev "[x"}})
    (local (wk-ok? wk) (pcall require :which-key))
    (when wk-ok?
      (wk.register {:c {:name :Conflict}} {:prefix :<leader>g :mode :n}))))

(pack :akinsho/git-conflict.nvim {:version "*" : config})
