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
        get-hex (. (require :cokeline.utils) :get_hex)
        win-fg (fn [buffer]
                 (if buffer.is_focused
                     (get-hex :Title :fg)
                     (get-hex :StatusLine :bg)))
        win-bg #(get-hex :StatusLineNC :bg)]
    (cokeline.setup {:buffers {:filter_visible (fn [buffer]
                                                 (and (not= buffer.type
                                                            :terminal)
                                                      (not= buffer.type :help)
                                                      (not= buffer.type :nofile)))
                               :new_buffers_position :directory}
                     ;; Only one supported for now
                     :sidebar {:filetype :NvimTree
                               :components [{:text "  File Explorer"
                                             :fg (get-hex :Title :fg)
                                             :bg (get-hex :StatusLineNC :bg)
                                             :style :bold}]}
                     :components [{:text " " :bg win-bg}
                                  {:text conf.separator.right
                                   :fg win-fg
                                   :bg win-bg}
                                  {:text (fn [buffer] buffer.devicon.icon)
                                   :fg (fn [buffer]
                                         (if buffer.is_focused
                                             (get-hex :StatusLine :bg)
                                             buffer.devicon.color))
                                   :bg win-fg}
                                  {:text (fn [buffer] buffer.unique_prefix)
                                   :bg win-fg
                                   :style (fn [buffer]
                                            (if buffer.is_focused :bold nil))}
                                  {:text (fn [buffer] buffer.filename)
                                   :bg win-fg
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
                                   :bg win-fg
                                   :style (fn [buffer]
                                            (if buffer.is_focused :bold nil))}
                                  {:text (fn [buffer]
                                           (if buffer.is_readonly " 🔒" ""))
                                   :bg win-fg}
                                  {:text (fn [buffer]
                                           (if buffer.is_modified " ●" ""))
                                   :bg win-fg}
                                  {:text conf.separator.left
                                   :fg win-fg
                                   :bg win-bg}]})))

{: config : init}
