(local {: pack} (require :lib))

(pack :Olical/conjure
      {:event [:BufReadPre :BufNewFile]
       :config #(let [maps {"conjure#mapping#prefix" :<leader>c
                            "conjure#mapping#def_word" :g
                            "conjure#mapping#doc_word" :h}]
                  (each [k v (pairs maps)] (tset vim.g k v)))})
