(local {: reg-ft : map!} (require :lib))

(each [_ x (ipairs ["fugitive" "fugitiveblame" "git" "help" "spectre_panel"])]
  (reg-ft x #(map! [:n] "q" ":close<cr>" {:silent true :buffer true} "Close")))
