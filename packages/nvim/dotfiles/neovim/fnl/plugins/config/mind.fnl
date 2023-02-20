(local {: map! : path-join} (require :lib))

(fn config []
  (let [mind (require :mind)]
    (map! [:n] :<leader>3 :<cmd>MindOpenSmartProject<CR> {:silent true}
          "Open Mind")
    (mind.setup {:persistence {:state_path (path-join conf.notes-dir
                                                      :mind/mind.json)
                               :data_dir (path-join conf.notes-dir :mind/data)}})))

{: config}
