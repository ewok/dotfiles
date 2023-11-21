(local {: reg-ft} (require :lib))

(reg-ft :fennel
        #(do
           (set vim.opt_local.expandtab true)
           (set vim.opt_local.shiftwidth 2)
           (set vim.opt_local.tabstop 2)
           (local (wk-ok? wk) (pcall require :which-key))
           (when wk-ok?
             (wk.register {:ec {:name "Eval Comment[conjure]"}
                           :e {:name "Eval[conjure]"}
                           :l {:name "Log[conjure]"}
                           :r {:name "Reset[conjure]"}
                           :t {:name "Test[conjure]"}}
                          {:prefix :<leader>c :mode :n :buffer 0}))))

