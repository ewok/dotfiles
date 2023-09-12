(local {: path-join : map!} (require :lib))

(fn config []
  (let [resession (require :resession)
        notify (require :notify)
        autgroup (vim.api.nvim_create_augroup :PersistedHooks {})]
    (resession.setup)
    (vim.api.nvim_create_autocmd :VimEnter
                                 {:group autgroup
                                  :callback (fn []
                                              (if vim.g.auto_load_session
                                                  (resession.load (vim.fn.getcwd)
                                                                  {:dir :dirsession
                                                                   :silence_errors true})))})
    ;; Highlight the session line after saving session
    (vim.api.nvim_create_autocmd :VimLeavePre
                                 {:group autgroup
                                  :callback #(resession.save (vim.fn.getcwd)
                                                             {:dir :dirsession
                                                              :notify false})})
    (map! [:n] :<leader>sl
          #(do
             (resession.load)
             (notify "Session loaded" :INFO {:title :Session}))
          {:silent true} "Session Load")
    (map! [:n] :<leader>su
          #(do
             (resession.load (vim.fn.getcwd)
                             {:dir :dirsession :silence_errors true})
             (notify "Session loaded" :INFO {:title :Session}))
          {:silent true} "Session Load")
    (map! [:n] :<leader>ss
          #(do
             (resession.save)
             (notify "Session saved success" :INFO {:title :Session}))
          {:silent true} "Session Save")
    (map! [:n] :<leader>sq #(do
                              (resession.save)
                              (vim.cmd :qall))
          {:silent true} "Session Quit")
    (map! [:n] :<leader>sd
          #(let [(ok _) (pcall resession.delete)]
             (if ok
                 (do
                   (notify "Session deleted success" :INFO {:title :Session}) ; (vim.cmd :qall)
                   )
                 (notify "Session deleted failure" :ERROR {:title :Session})))
          {:silent true} "Session Delete")))

{: config}
