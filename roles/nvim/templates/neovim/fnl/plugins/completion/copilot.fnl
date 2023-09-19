(local {: pack : map!} (require :lib))

(pack :zbirenbaum/copilot.lua
      {:event [:InsertEnter]
       :config #(let [copilot (require :copilot) ; cmp (require :cmp)
                      ]
                  ;; (: cmp.event :on :menu_opened
                  ;;    #(set vim.b.copilot_suggestion_hidden true))
                  ;; (: cmp.event :on :menu_closed
                  ;;    #(set vim.b.copilot_suggestion_hidden false))
                  (map! :n :<leader>cc "<cmd>Copilot toggle<cr>" {:silent true}
                        "Toggle Copilot")
                  (copilot.setup {:filetypes {:yaml true :markdown true}
                                  :suggestion {:enabled true
                                               :auto_trigger true
                                               :keymap {:accept :<C-l>
                                                        :next :<C-n>
                                                        :prev :<C-p>
                                                        :dismiss :<C-k>}}
                                  :panel {:enabled false}}))})
