(local {: reg-ft : map!} (require :lib))

; TODO: Might be generalized
(each [_ x (ipairs ["fugitive" "fugitiveblame" "git" "help" "replacer" "spectre_panel"])]
  (reg-ft x #(map! [:n] "q" ":close<cr>" {:silent true :buffer true} "Close")))
