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
  (map! :n :<leader>bo :<cmd>BufOnly<cr> {:silent true}
        "Close all buffers except current")
  (for [i 1 9]
    (map! :n (.. :<leader> :b i) (.. "<Plug>(cokeline-focus-" i ")")
          {:silent true} (.. "Go to buffer " i))))

;; TODO: Tabs and custom area
(fn config []
  (let [cokeline (require :cokeline)
        get-hex (. (require :cokeline.utils) :get_hex)
        active-fg #(get-hex :lualine_a_normal :fg)
        active-bg #(get-hex :lualine_a_normal :bg)
        inactive-fg #(get-hex :lualine_b_normal :fg)
        inactive-bg #(get-hex :lualine_b_normal :bg)
        win-fg (fn [buffer]
                 (if buffer.is_focused
                     (active-fg)
                     (inactive-fg)))
        win-bg (fn [buffer]
                 (if buffer.is_focused
                     (active-bg)
                     (inactive-bg)))]
    (cokeline.setup {:buffers {:filter_visible (fn [buffer]
                                                 (and (not= buffer.type
                                                            :terminal)
                                                      (not= buffer.type :help)
                                                      (not= buffer.type :nofile)))
                               :new_buffers_position :directory}
                     ;; Only one supported for now
                     :sidebar {:filetype :NvimTree
                               :components [{:text "  File Explorer"
                                             :fg win-fg
                                             :bg win-bg
                                             :style :bold}]}
                     :default_hl {:fg win-fg :bg win-bg}
                     :components [;{:text " "}
                                  {:text (fn [buffer]
                                           (if buffer.is_focused
                                               conf.separator.left
                                               " "))
                                   :bg (fn [buffer]
                                         (if buffer.is_focused
                                             (active-bg) (inactive-bg)))
                                   :fg (fn [buffer]
                                         (if buffer.is_focused
                                             (active-fg)
                                             (inactive-fg)))}
                                  {:text (fn [buffer] buffer.devicon.icon)
                                   :fg (fn [buffer]
                                         (if buffer.is_focused
                                             (active-fg)
                                             buffer.devicon.color))}
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
                                             (get-hex :ErrorMsg :fg)
                                             (if (not= buffer.diagnostics.warnings
                                                       0)
                                                 (get-hex :IncSearch :bg)
                                                 nil)))
                                   :style (fn [buffer]
                                            (if buffer.is_focused :bold nil))}
                                  {:text (fn [buffer]
                                           (if buffer.is_readonly " 🔒" ""))}
                                  {:text (fn [buffer]
                                           (if buffer.is_modified " ●" ""))}
                                  {:text (fn [buffer]
                                           (if buffer.is_focused
                                               conf.separator.left
                                               " "))
                                   ; :fg win-fg
                                   :fg (fn [buffer]
                                         (if buffer.is_focused
                                             (active-bg)
                                             (inactive-bg)))
                                   :bg (fn [buffer]
                                         (if buffer.is_focused
                                             (active-fg)
                                             (inactive-fg)))
                                   ; :fg win-bg
                                   ; :fg (inactive-bg)
                                   }]})))

{: config : init}
