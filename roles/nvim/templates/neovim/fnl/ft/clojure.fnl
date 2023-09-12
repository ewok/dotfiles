(local {: reg-ft} (require :lib))

(reg-ft :clojure
        #(do
           (set vim.opt_local.expandtab true)
           (set vim.opt_local.shiftwidth 2)
           (set vim.opt_local.tabstop 2)
           (local (wk-ok? wk) (pcall require :which-key))
           (when wk-ok?
             (wk.register {:c {:name "Connect[conjure]"}
                           :ec {:name "Eval Comment[conjure]"}
                           :e {:name "Eval[conjure]"}
                           :l {:name "Log[conjure]"}
                           :r {:name "Refresh[conjure]"}
                           :s {:name "Session[conjure]"}
                           :t {:name "Test[conjure]"}
                           :v {:name "View[conjure]"}}
                          {:prefix :<leader>c :mode :n :buffer 0}))))
