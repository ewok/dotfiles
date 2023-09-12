(local {: reg-ft : map!} (require :lib))

(reg-ft :floggraph #(do
                      (map! [:n] :q :<cmd>close<cr> {:silent true :buffer true}
                            :Close)
                      (local (wk-ok? wk) (pcall require :which-key))
                      (when wk-ok?
                        (wk.register {:c {:name "[Git] Commit"}
                                      :c? ["[Git] Help"]
                                      :c<space> ["[Git] Git commit_"]
                                      :cA ["[Git] Squash(with message)"]
                                      :cf ["[Git] Fixup"]
                                      :cF ["[Git] Fixup and rebase"]
                                      :cs ["[Git] Squash"]
                                      :cS ["[Git] Squash and rebase"]
                                      :cb {:name "[Git] Git branch"}
                                      :cb<space> ["[Git] Git branch_"]
                                      :cm {:name "[Git] Merge..."}
                                      :cm<space> ["[Git] Git merge_"]
                                      :co {:name "[Git] Checkout..."}
                                      :co<space> ["[Git] Git checkout_"]
                                      :cob ["[Git] Checkout branch under cursor"]
                                      :col ["[Git] Checkout local branch under cursor"]
                                      :coo ["[Git] Checkout under cursor"]
                                      :cr {:name "[Git] Revert..."}
                                      :cr<space> ["[Git] Git revert_"]
                                      :crc ["[Git] Revert Commit"]
                                      :crn ["[Git] Revert Commit w/o changes"]
                                      :r {:name "[Git] Rebase"}
                                      :r? ["[Git] Help"]
                                      :r<space> ["[Git] Git rebase_"]
                                      :ra ["[Git] Abort rebase"]
                                      :rd ["[Git] 'Drop' commit"]
                                      :re ["[Git] Edit rebase"]
                                      :rf ["[Git] Autosquash rebase"]
                                      :ri ["[Git] Interactive rebase"]
                                      :rm ["[Git] 'Edit' commit"]
                                      :rp ["[Git] Rebase push"]
                                      :rr ["[Git] Continue rebase"]
                                      :rs ["[Git] Skip rebase"]
                                      :ru ["[Git] Rebase upstream"]
                                      :rw ["[Git] 'Reword' commit"]
                                      :g/ ["[Git] Search"]
                                      :g? ["[Git] Help"]
                                      "g\\" ["[Git] Patch Search"]
                                      :gm ["[Git] Toggle Merge"]
                                      :gp ["[Git] Toggle Patch"]
                                      :gq ["[Git] Quit"]
                                      :gr ["[Git] Toggle Reflog"]
                                      :gu ["[Git] Vsplit Untracked"]
                                      :gU ["[Git] Vsplit Unstaged"]
                                      :gx ["[Git] Toogle Graph"]
                                      :gs ["[Git] Show Staged"]
                                      :ga ["[Git] Toggle All"]
                                      :gb ["[Git] Toggle Bisect"]
                                      :go {:name "[Git] Order..."}
                                      :goa ["[Git] by Author"]
                                      :god ["[Git] by Date"]
                                      :goo ["[Git] Cycle Order"]
                                      :gor ["[Git] Reverse"]
                                      :got ["[Git] Topo"]
                                      :d! ["[Git] Diff Last Commit"]
                                      :d? ["[Git] Help"]
                                      :dd ["[Git] Diffsplit"]
                                      :dq ["[Git] Close all but one"]
                                      :dv ["[Git] Vertical Diffsplit"]
                                      :cot :which_key_ignore
                                      "g%" :which_key_ignore
                                      :g<space> :which_key_ignore
                                      :ge :which_key_ignore
                                      :gf :which_key_ignore
                                      :gj :which_key_ignore
                                      :gJ :which_key_ignore
                                      :gn :which_key_ignore
                                      :gN :which_key_ignore
                                      :gv :which_key_ignore
                                      :ds :which_key_ignore}
                                     {:mode :n :buffer 0}))))

(each [_ x (ipairs [:fugitive :fugitiveblame :git])]
  (reg-ft x #(do
               (map! [:n] :q :<cmd>bdelete<cr> {:silent true :buffer true}
                     :Close)
               (map! [:n] :r "<cmd>WhichKey r<cr>" {:silent true :buffer true}
                     :Close)
               (local (wk-ok? wk) (pcall require :which-key))
               (when wk-ok?
                 (wk.register {:c {:name "[Git] Commit"}
                               :c<space> ["[Git] Git commit_"]
                               :c? ["[Git] Help"]
                               :cA ["[Git] Squash(with message)"]
                               :cF ["[Git] Fixup and rebase"]
                               :cR {:name "[Git] Git re-author "}
                               :cS ["[Git] Squash and rebase"]
                               :ca ["[Git] Amend the last"]
                               :cb {:name "[Git] Git branch "}
                               :cb? ["[Git] Help"]
                               :cc ["[Git] Create a commit"]
                               :ce ["[Git] Amend the last(w/o message)"]
                               :cf ["[Git] Fixup"]
                               :cm {:name "[Git] Merge..."}
                               :cm<space> ["[Git] Git merge_"]
                               :co {:name "[Git] Checkout..."}
                               :co<space> ["[Git] Git checkout_"]
                               :co? ["[Git] Help"]
                               :coo ["[Git] Checkout under cursor"]
                               :cr {:name "[Git] Revert..."}
                               :cr<space> ["[Git] Git revert_"]
                               :cr? ["[Git] Help"]
                               :crc ["[Git] Revert Commit"]
                               :crn ["[Git] Revert Commit w/o changes"]
                               :cs ["[Git] Squash"]
                               :cv {:name "[Git] -v..."}
                               :cva ["[Git] Amend with -v"]
                               :cvc ["[Git] Commit with -v"]
                               :cw ["[Git] Reword the last"]
                               :cz {:name "[Git] Stash..."}
                               :cz<space> ["[Git] Git stash_"]
                               :cz? ["[Git] Help"]
                               :czA ["[Git] Apply topmost"]
                               :czP ["[Git] Pop topmost"]
                               :cza ["[Git] Apply topmost preserving index"]
                               :czp ["[Git] Pop topmost preserving index"]
                               :czs ["[Git] Push"]
                               :czw ["[Git] Push --keep-index"]
                               :czz ["[Git] Push"]
                               :r {:name "[Git] Rebase"}
                               :ri ["[Git] Interactive rebase"]
                               :rf ["[Git] Autosquash rebase"]
                               :ru ["[Git] Rebase upstream"]
                               :rp ["[Git] Rebase push"]
                               :rr ["[Git] Continue rebase"]
                               :rs ["[Git] Skip rebase"]
                               :ra ["[Git] Abort rebase"]
                               :re ["[Git] Edit rebase"]
                               :rw ["[Git] 'Reword' commit"]
                               :rm ["[Git] 'Edit' commit"]
                               :rd ["[Git] 'Drop' commit"]
                               :rk ["[Git] 'Drop' commit"]
                               :rx ["[Git] 'Drop' commit"]
                               :r<space> ["[Git] Git rebase_"]
                               :r? ["[Git] Help"]
                               :gI ["[Git] Edit Ignore"]
                               :gO ["[Git] Open the file"]
                               :gu ["[Git] Jump to Untracked or Unstaged"]
                               :gU ["[Git] Jump to Unstaged"]
                               :gs ["[Git] Jump to Staged"]
                               :gp ["[Git] Jump to Unpushed"]
                               :gP ["[Git] Jump to Unpulled"]
                               :gr ["[Git] Jump to Rebasing"]
                               :gi ["[Git] Open .gitignore"]
                               :gq ["[Git] Close"]
                               :g? ["[Git] Help"]
                               :dp ["[Git] Diff"]
                               :dd ["[Git] Diffsplit"]
                               :dv ["[Git] Vertical Diffsplit"]
                               :ds ["[Git] Horizontal Diffsplit"]
                               :dh ["[Git] Horizontal Diffsplit"]
                               :dq ["[Git] Close all but one"]
                               :d? ["[Git] Help"]}
                              {:mode :n :buffer 0})))))
