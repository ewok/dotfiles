(local {: reg-ft} (require :lib))

(reg-ft :python
        #(do
           (set vim.opt_local.expandtab true)
           (set vim.opt_local.shiftwidth 4)
           (set vim.opt_local.tabstop 4)
           (set vim.opt_local.softtabstop 4)
           (local (wk-ok? wk) (pcall require :which-key))
           (when wk-ok?
             (wk.register {:c {:name "Connect[conjure]"}
                          :ec {:name "Eval Comment[conjure]"}
                           :e {:name "Eval[conjure]"}
                           :l {:name "Log[conjure]"}
                           :r {:name "Reset[conjure]"}}
                          {:prefix :<leader>c :mode :n :buffer 0}))))

