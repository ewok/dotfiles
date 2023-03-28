(local {: reg-ft : map!} (require :lib))

(reg-ft :qf
        #(do
           (map! [:n] :q "<cmd>bdelete<cr>" {:silent true :buffer true} :Close)
           (map! [:n] "n" ":cnext|wincmd p<cr>" {:silent true :buffer true}
                 "Next C item")
           (map! [:n] "p" ":cprevious|wincmd p<cr>"
                 {:silent true :buffer true} "Previous C item")
           (map! [:n] "]l" ":lnext|wincmd p<cr>" {:silent true :buffer true}
                 "Next L item")
           (map! [:n] "[l" ":lprevious|wincmd p<cr>"
                 {:silent true :buffer true} "Previous L item")))
