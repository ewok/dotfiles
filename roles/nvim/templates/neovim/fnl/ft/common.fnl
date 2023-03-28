(local {: reg-ft : map!} (require :lib))

(each [_ x (ipairs ["help" "spectre_panel"])]
  (reg-ft x #(map! [:n] "q" "<cmd>bdelete<cr>" {:silent true :buffer true} "Close")))
