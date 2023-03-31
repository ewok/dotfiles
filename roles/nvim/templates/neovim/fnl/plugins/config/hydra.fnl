(local hint "^Spell Langs       ^
       ^
       ^^^^^_1_ %{spell?} spell
       ^^^^^_2_ %{en_us?} en
       ^^^^^_3_ %{ru_ru?} ru
       ^^^^^_q_ quit
       ")

(fn config []
  (let [hydra (require :hydra)]
    (hydra {:name :Spell
            : hint
            :config {:invoke_on_body true
                     :hint {:border :rounded
                            :position :middle
                            :funcs {:spell? #(if vim.wo.spell "[x]" "[ ]")
                                    :en_us? #(if (= vim.bo.spelllang :en_us)
                                                 "[x]"
                                                 "[ ]")
                                    :ru_ru? #(if (= vim.bo.spelllang :ru_ru)
                                                 "[x]"
                                                 "[ ]")}}}
            :mode :n
            :body :<leader>7
            :heads [[:1 #(set vim.wo.spell (not vim.wo.spell)) {:desc :toggle}]
                    [:2 #(set vim.bo.spelllang :en_us) {}]
                    [:3 #(set vim.bo.spelllang :ru_ru) {}]
                    [:q nil {:exit true}]]})))

{: config}
