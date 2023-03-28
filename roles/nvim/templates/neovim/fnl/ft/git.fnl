(local {: reg-ft : map!} (require :lib))
(local (wk-ok? wk) (pcall require :which-key))

(each [_ x (ipairs [:fugitive :fugitiveblame :git :floggraph])]
  (reg-ft x #(do
               (map! [:n] :q :<cmd>bdelete<cr> {:silent true :buffer true}
                     :Close)
               (map! [:n] :r "<cmd>WhichKey r<cr>" {:silent true :buffer true}
                     :Close)
               (when wk-ok?
                 (wk.register {:c {:name "[Git] Commit"}
                               :cc ["[Git] Create a commit"]
                               :ca ["[Git] Amend the last"]
                               :ce ["[Git] Amend the last(w/o message)"]
                               :cw ["[Git] Reword the last"]
                               :cf ["[Git] Fixup"]
                               :cF ["[Git] Fixup and rebase"]
                               :cs ["[Git] Squash"]
                               :cS ["[Git] Squash and rebase"]
                               :cA ["[Git] Squash(with message)"]
                               :c<space> ["[Git] Git commit "]
                               :cr {:name "[Git] Revert..."}
                               :crc ["[Git] Revert Commit"]
                               :crn ["[Git] Revert Commit w/o changes"]
                               :cr<space> ["[Git] Git revert "]
                               :cr? ["[Git] Help"]
                               :cm {:name "[Git] Merge..."}
                               :cm<space> ["[Git] Git merge "]
                               :cv {:name "[Git] -v..."}
                               :cvc ["[Git] Commit with -v"]
                               :cva ["[Git] Amend with -v"]
                               :co {:name "[Git] Checkout..."}
                               :coo ["[Git] Checkout under cursor"]
                               :co<space> ["[Git] Git checkout"]
                               :cb {:name "[Git] Git branch "}
                               :c? ["[Git] Help"]
                               :co? ["[Git] Help"]
                               :cb? ["[Git] Help"]
                               :cz {:name "[Git] Stash..."}
                               :czz ["[Git] Push"]
                               :czw ["[Git] Push --keep-index"]
                               :czs ["[Git] Push"]
                               :czA ["[Git] Apply topmost"]
                               :cza ["[Git] Apply topmost preserving index"]
                               :czP ["[Git] Pop topmost"]
                               :czp ["[Git] Pop topmost preserving index"]
                               :cz<space> ["[Git] Git stash "]
                               :cR {:name "[Git] Git re-author "}
                               :cz? ["[Git] Help"]
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
                               :r<space> ["[Git] Git rebase "]
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
