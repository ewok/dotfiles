;; Which-Key
(local {: pack} (require :lib))

(fn config []
  (let [wk (require :which-key)]
    (wk.setup {:plugins {:presets {:operators false :motions true}
                         :spelling {:enabled true :suggestions 20}}
               :icons {:breadcrumb conf.icons.wk.breadcrumb
                       :separator conf.icons.wk.separator
                       :group conf.icons.wk.group}
               :operators {:gc :Comments}
               :window {:border :single}})
    (wk.register {:8 "Dark/Light theme"
                  :c {:name :Code}
                  :f {:name :Find}
                  :fs {:name :Settings}
                  :g {:name :Git}
                  :gf {:name "Git Fetch"}
                  :gh {:name "Git Hunk"}
                  :gl {:name "Git Log"}
                  :gt {:name "Git Toggle"}
                  :gp {:name "Git Push"}
                  :i {:name :Insert}
                  :l {:name :Lsp}
                  :o {:name :Open}
                  :p {:name "Packer | Profiling"}
                  :r {:name :Replace :w "Replace Word To ..."}
                  :s {:name :Session}
                  :y {:name :Yank}
                  :yf {:name :File}
                  :t {:name :Toggle}
                  :w {:name :Wiki}}
                 {:prefix :<leader> :mode :n})
    (wk.register {:6 {:name :Base64}
                  :c {:name :Code}
                  :g {:name :Git}
                  :gl {:name "Git Log"}
                  :gh {:name :Hunk}
                  :y {:name :Yank}
                  :w {:name :Wiki}}
                 {:prefix :<leader> :mode :x})
    (wk.register {:c {:name :Comment
                      :c "Toggle line comment"
                      :b "Toggle block comment"
                      :a "Insert line comment to line end"
                      :j "Insert line comment to next line"
                      :k "Insert line comment to previous line"}}
                 {:prefix :g :mode :n})))

(pack :folke/which-key.nvim {: config})
