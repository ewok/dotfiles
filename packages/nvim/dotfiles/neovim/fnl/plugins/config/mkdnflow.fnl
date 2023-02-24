(local opts {:modules {:bib false
                       :buffers true
                       :conceal true
                       :cursor true
                       :folds false
                       :links true
                       :lists true
                       :maps true
                       :paths true
                       :tables true
                       :yaml false}
             :filetypes {:md true :rmd true :markdown true}
             :create_dirs true
             :perspective {:priority :first
                           :fallback :current
                           :root_tell false
                           :nvim_wd_heel true}
             :wrap false
             :silent false
             :links {:style :markdown
                     :name_is_source false
                     :conceal true
                     :context 1
                     ;0
                     :implicit_extension nil
                     :transform_implicit false
                     :transform_explicit (fn [text]
                                           (-> text
                                               (str/replace " " "-")
                                               (str/lower-case)
                                               (str/join (str (time/now) "_"))))}
             :to_do {:symbols [" " :p :X]
                     :update_parents true
                     :not_started " "
                     :in_progress :p
                     :complete :X}
             :tables {:trim_whitespace true
                      :format_on_move true
                      :auto_extend_rows false
                      :auto_extend_cols false}
             :mappings {:MkdnEnter [[:n :v] :<M-CR>]
                        :MkdnTab false
                        :MkdnSTab false
                        :MkdnNextLink [:n "]l"]
                        :MkdnPrevLink [:n "[l"]
                        :MkdnNextHeading [:n "]]"]
                        :MkdnPrevHeading [:n "[["]
                        :MkdnGoBack [:n :<BS>]
                        :MkdnGoForward [:n :<Del>]
                        :MkdnFollowLink false
                        :MkdnMoveSource [:n :<leader>wr]
                        :MkdnYankAnchorLink [:n :ya]
                        :MkdnYankFileAnchorLink [:n :yfa]
                        :MkdnIncreaseHeading [:n "+"]
                        :MkdnDecreaseHeading [:n "-"]
                        :MkdnToggleToDo [[:n :v] :<C-Space>]
                        :MkdnNewListItem [:i :<CR>]
                        :MkdnNewListItemBelowInsert [:n :o]
                        :MkdnNewListItemAboveInsert [:n :O]
                        :MkdnExtendList false
                        :MkdnUpdateNumbering [:n :<leader>wN]
                        :MkdnTableFormat [:n :tf]
                        :MkdnTableNewColAfter [:n :ta]
                        :MkdnTableNewColBefore [:n :ti]
                        :MkdnTableNewRowAbove [:n :tO]
                        :MkdnTableNewRowBelow [:n :to]
                        :MkdnTableNextCell [:i :<Tab>]
                        :MkdnTableNextRow [:i :<C-Down>]
                        :MkdnTablePrevCell [:i :<S-Tab>]
                        :MkdnTablePrevRow [:i :<C-Up>]
                        :MkdnFoldSection [:n :zf]
                        :MkdnUnfoldSection [:n :zF]}})

{: opts}
