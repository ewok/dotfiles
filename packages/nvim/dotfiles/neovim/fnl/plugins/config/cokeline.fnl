(local {: map!} (require :lib))

(fn init []
  (map! :n :<C-W>d :<cmd>BufferDelete<cr> {:silent true} "Close current buffer")
  (map! :n :<C-W><C-D> :<cmd>BufferDelete<cr> {:silent true}
        "Close current buffer")
  (map! :n :<S-Tab> "<Plug>(cokeline-focus-prev)" {:silent true}
        "Go to left buffer")
  (map! :n :<Tab> "<Plug>(cokeline-focus-next)" {:silent true}
        "Go to right buffer")
  (map! :n :<leader>bn :<cmd>enew<cr> {:silent true} "Create new buffer")
  (for [i 1 9]
    (map! :n (.. :<leader> :b i) (.. "<Plug>(cokeline-focus-" i ")")
          {:silent true} (.. "Go to buffer " i)))
  (map! :n :<leader>bo :<cmd>BufOnly<cr> {:silent true}
        "Close all buffers except current"))

;; TODO: Tabs and custom area
(fn config []
  (let [cokeline (require :cokeline)
        sep-fg (fn [buffer]
                 (if buffer.is_focused
                     conf.colors.base00
                     conf.colors.base00))
        sep-bg (fn [buffer]
                 (if buffer.is_focused
                     conf.colors.base0C
                     conf.colors.base02))]
    (cokeline.setup {:buffers {:filter_visible (fn [buffer]
                                                 (and (not= buffer.type
                                                            :terminal)
                                                      (not= buffer.type :help)
                                                      (not= buffer.type :nofile)))}
                     ;; Only one supported for now
                     :sidebar {:filetype :NvimTree
                               :components [{:text "  File Explorer"
                                             :fg conf.colors.base0C
                                             :bg conf.colors.base00
                                             :style :bold}]}
                     :default_hl {:fg (fn [buffer]
                                        (if buffer.is_focused
                                            conf.colors.base00
                                            conf.colors.base05))
                                  :bg sep-bg}
                     :components [{:text " " :bg conf.colors.base00}
                                  {:text conf.separator.right
                                   :fg sep-bg
                                   :bg sep-fg}
                                  {:text (fn [buffer] buffer.devicon.icon)
                                   :fg (fn [buffer]
                                         (if buffer.is_focused
                                             conf.colors.base02
                                             conf.colors.base04))}
                                  {:text (fn [buffer] buffer.unique_prefix)
                                   :style (fn [buffer]
                                            (if buffer.is_focused :bold nil))}
                                  {:text (fn [buffer] buffer.filename)
                                   :style (fn [buffer]
                                            (if buffer.is_focused :bold nil))}
                                  {:text (fn [buffer]
                                           (if (not= buffer.diagnostics.errors
                                                     0)
                                               (.. "  "
                                                   buffer.diagnostics.errors)
                                               (if (not= buffer.diagnostics.warnings
                                                         0)
                                                   (.. "  "
                                                       buffer.diagnostics.warnings)
                                                   "")))
                                   :fg (fn [buffer]
                                         (if (not= buffer.diagnostics.errors 0)
                                             conf.colors.base0F
                                             (if (not= buffer.diagnostics.warnings
                                                       0)
                                                 conf.colors.base09
                                                 nil)))
                                   :style (fn [buffer]
                                            (if buffer.is_focused :bold nil))}
                                  {:text (fn [buffer]
                                           (if buffer.is_readonly " 🔒" ""))}
                                  {:text (fn [buffer]
                                           (if buffer.is_modified " ●" ""))}
                                  {:text conf.separator.left
                                   :fg sep-bg
                                   :bg sep-fg}]})))

{: config : init}
