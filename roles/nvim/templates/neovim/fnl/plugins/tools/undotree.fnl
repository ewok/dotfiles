;; Undo tree
(local {: pack : path-join : map! : toggle_sidebar} (require :lib))

(fn config []
  (let [undotree-dir (path-join conf.cache-dir :undotree)
        target_path (vim.fn.expand undotree-dir)
        notify (require :notify)]
    (set vim.g.undotree_CustomUndotreeCmd "topleft vertical 30 new")
    (set vim.g.undotree_CustomDiffpanelCmd "belowright 10 new")
    (set vim.g.undotree_SetFocusWhenToggle 1)
    (when (= 1 (vim.fn.has :persistent_undo))
      (when (not (vim.fn.isdirectory target_path))
        (when (not (vim.fn.isdirectory target_path))
          (vim.fn.mkdir target_path :p 700))
        (set vim.o.undofile true)
        (set vim.o.undodir target_path)))
    (map! :n :<leader>4
          #(do
             (toggle_sidebar :undotree)
             (let [(ok _) (pcall vim.cmd :UndotreeToggle)]
               (if (not ok)
                   (notify "Can't open undotree" :ERROR :Undotree))))
          {:silent true} "Open Undo Explorer")))

(pack :mbbill/undotree {: config :event [:BufReadPre :BufNewFile]})
