(local {: map!} (require :lib))

(fn config []
  (let [spider (require :spider)]
    (map! [:n :o :x] :w #(spider.motion :w) {} :Spider-w)
    (map! [:n :o :x] :e #(spider.motion :e) {} :Spider-e)
    (map! [:n :o :x] :b #(spider.motion :b) {} :Spider-b)
    (map! [:n :o :x] :ge #(spider.motion :ge) {} :Spider-ge)
    (spider.setup {})))

{: config}
