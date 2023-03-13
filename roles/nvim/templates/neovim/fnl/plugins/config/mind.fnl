(local {: map! : path-join : toggle_sidebar} (require :lib))

(fn config []
  (let [mind (require :mind)]
    (map! [:n] :<leader>3
          #(do
             (toggle_sidebar :mind)
             (vim.cmd :MindOpenSmartProject)) {:silent true}
          "Open Mind")
    (mind.setup {:persistence {:state_path (path-join conf.notes-dir
                                                      :mind/mind.json)
                               :data_dir (path-join conf.notes-dir :mind/data)}})))

{: config}
