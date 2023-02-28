(local {: map! : toggle_sidebar } (require :lib))

(fn config []
  ;; TODO: Find this. Seems empty ; (set vim.g.dbs conf.options.database_connect)
  (set vim.g.db_ui_winwidth 40)
  (set vim.g.db_ui_auto_execute_table_helpers true)
  (set vim.g.db_ui_execute_on_save false)
  (map! :n :<leader>5 #(do
                         (toggle_sidebar :dbui)
                         (vim.cmd :DBUIToggle))
                         {:silent true}
                         "Open Database Explorer"))

{:build [:<CMD>DBUIToggle<CR>] : config}
