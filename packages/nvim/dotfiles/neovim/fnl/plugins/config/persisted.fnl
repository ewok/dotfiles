(local {: path-join : map! : toggle_sidebar} (require :lib))

(fn config []
  (let [persisted (require :persisted)
        notify (require :notify)
        autgroup (vim.api.nvim_create_augroup :PersistedHooks {})]
    (persisted.setup {:save_dir (path-join conf.cache-dir :sessions)
                      :use_git_branche true
                      :command :VimLeavePre
                      :autosave true})
    ;; Close unsaveable buffers before saving session
    (vim.api.nvim_create_autocmd :User
                                 {:pattern :PersistedSavePre
                                  :group autgroup
                                  :callback #(toggle_sidebar)})
    ;; Highlight the session line after saving session
    (vim.api.nvim_create_autocmd :User
                                 {:pattern :PersistedSavePost
                                  :group autgroup
                                  :callback #(vim.cmd :nohlsearch)})
    (map! [:n] :<leader>sl
          #(do
             (vim.cmd "silent! SessionLoad")
             (notify "Session loaded" :INFO {:title :Session}))
          {:silent true} "Session Load")
    (map! [:n] :<leader>ss
          #(do
             (vim.cmd "silent! SessionSave")
             (notify "Session saved success" :INFO {:title :Session}))
          {:silent true} "Session Save")
    (map! [:n] :<leader>sq #(do
                              (vim.cmd "silent! SessionSave")
                              (vim.cmd :qall))
          {:silent true} "Session Quit")
    (map! [:n] :<leader>sd
          #(let [(ok _) (pcall vim.cmd :SessionDelete)]
             (if ok
                 (notify "Session deleted success" :INFO {:title :Session})
                 (notify "Session deleted failure" :ERROR {:title :Session})))
          {:silent true} "Session Delete")))

{: config}
