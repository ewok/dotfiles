;; Mind

(local {: pack : map! : path-join : toggle_sidebar} (require :lib))

(fn init []
  (map! [:n] :<leader>3
        #(do
           (toggle_sidebar :mind)
           (vim.cmd :MindOpenSmartProject)) {:silent true} "Open Mind"))

(fn config []
  (let [mind (require :mind)]
    (mind.setup {:persistence {:state_path (path-join conf.notes-dir
                                                      :mind/mind.json)
                               :data_dir (path-join conf.notes-dir :mind/data)}})))

(pack :phaazon/mind.nvim {: config : init :cmd [:MindOpenSmartProject]})
