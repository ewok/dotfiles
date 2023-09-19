(local {: pack : map!} (require :lib))

(fn config []
  (let [flash (require :flash)]
    (map! [:n :o :x] :s #(flash.jump) {:silent true} :Flash)
    ; (map! [:n :o :x] :S #(flash.treesitter) {:silent true} :FlashTreesitter)
    (map! :o :r #(flash.remote) {:silent true} :FlashRemote)
    (map! [:o :x] :R #(flash.treesitter_search) {:silent true}
          :FlashTreesitterSearch)
    (map! :c :<c-s> #(flash.toggle) {:silent true} :FlashToggle)))

(if (= :flash conf.options.motion_plugin)
    (pack :folke/flash.nvim {:event :VeryLazy :opts {} : config})
    [])
