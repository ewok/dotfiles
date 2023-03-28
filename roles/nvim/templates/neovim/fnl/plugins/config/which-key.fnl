(fn config []
  (let [wk (require :which-key)]
    (wk.setup {:plugins {:presets {:operators false :motions true}
                         :spelling {:enabled true :suggestions 20}}
               :icons {:breadcrumb " " :separator " " :group " "}
               :operators {:gc :Comments}
               :window {:border :single}})
    (wk.register {:b {:name :Buffers}
                  :c {:name :Code}
                  :f {:name :Find}
                  :fs {:name :Settings}
                  :g {:name :Git}
                  :gf {:name "Git Fetch"}
                  :gl {:name "Git Log"}
                  :gt {:name "Git Toggle"}
                  :gp {:name "Git Push"}
                  :i {:name :Insert}
                  :l {:name :Lsp}
                  :p {:name "Packer | Profiling"}
                  :r {:name :Replace :w "Replace Word To ..."}
                  :s {:name :Session}
                  :y {:name :Yank}
                  :yf {:name :File}
                  :t {:name :Toggle}
                  :w {:name :Wiki}}
                 {:prefix :<leader> :mode :n})
    (wk.register {:c {:name :Comment
                      :c "Toggle line comment"
                      :b "Toggle block comment"
                      :a "Insert line comment to line end"
                      :j "Insert line comment to next line"
                      :k "Insert line comment to previous line"}}
                 {:prefix :g :mode :n})))

{: config}
