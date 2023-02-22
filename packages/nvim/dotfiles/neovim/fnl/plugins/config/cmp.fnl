(fn under_compare [entry1 entry2]
  (let [entry1_under (string.find entry1.completion_item.label "^_+")
        entry2_under (string.find entry2.completion_item.label "^_+")]
    (< (or entry1_under 0) (or entry2_under 0))))

(local complete_window_settings {:fixed true :min_width 20 :max_width 40})

(local duplicate_keywords {:vsnip 1
                           :nvim_lsp 1
                           :buffer 0
                           :path 0
                           :cmdline 0
                           :vim-dadbod-completion 0
                           :conjure 0})

(fn config []
  (let [cmp (require :cmp)
        types (require :cmp.types)]
    (let [config_opts {:preselect types.cmp.PreselectMode.None
                       :confirmation {:default_behavior cmp.ConfirmBehavior.Insert}
                       :snippet {:expand (fn [args]
                                           (vim.call "vsnip#anonymous"
                                                     args.body))}
                       :sources (cmp.config.sources [{:name :calc}
                                                     {:name :vsnip}
                                                     {:name :nvim_lsp}
                                                     {:name :conjure}
                                                     {:name :path}
                                                     {:name :buffer}
                                                     {:name :vim-dadbod-completion}])
                       :mapping {:<cr> (cmp.mapping (cmp.mapping.confirm)
                                                    [:i :s :c])
                                 :<c-p> (cmp.mapping (cmp.mapping.select_prev_item)
                                                     [:i :s :c])
                                 :<c-n> (cmp.mapping (cmp.mapping.select_next_item)
                                                     [:i :s :c])
                                 :<c-b> (cmp.mapping (cmp.mapping.scroll_docs -5)
                                                     [:i :s :c])
                                 :<c-f> (cmp.mapping (cmp.mapping.scroll_docs 5)
                                                     [:i :s :c])
                                 :<c-u> (cmp.mapping (fn [fallback]
                                                       (if (cmp.visible)
                                                           (for [i 1 5 1]
                                                             (cmp.select_prev_item {:behavior cmp.SelectBehavior.Select}))
                                                           (fallback)))
                                                     [:i :s :c])
                                 :<c-d> (cmp.mapping (fn [fallback]
                                                       (if (cmp.visible)
                                                           (for [i 1 5 1]
                                                             (cmp.select_next_item {:behavior cmp.SelectBehavior.Select}))
                                                           (fallback)))
                                                     [:i :s :c])
                                 :<c-k> (cmp.mapping (fn []
                                                       (if (cmp.visible)
                                                           (cmp.abort)
                                                           (cmp.complete)))
                                                     [:i :s :c])}
                       :sorting {:priority_weight 2
                                 :comparators [cmp.config.compare.offset
                                               cmp.config.compare.exact
                                               cmp.config.compare.score
                                               under_compare
                                               cmp.config.compare.kind
                                               cmp.config.compare.sort_text
                                               cmp.config.compare.length
                                               cmp.config.compare.order]}
                       :window (if conf.options.float_border
                                   {:completion (cmp.config.window.bordered {:winhighlight "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None"})
                                    :documentation (cmp.config.window.bordered {:winhighlight "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None"})}
                                   {})
                       :formatting {:format (fn [entry vim_item]
                                              (let [kind vim_item.kind
                                                    source entry.source.name]
                                                (set vim_item.kind
                                                     (string.format "%s %s"
                                                                    (. conf.icons
                                                                       kind)
                                                                    kind))
                                                (set vim_item.menu
                                                     (string.format "<%s>"
                                                                    (string.upper source)))
                                                (set vim_item.dup
                                                     (or (. duplicate_keywords
                                                            source)
                                                         0))
                                                ;; if complete_window_settings.fixed and vim.fn.mode() == "i" then
                                                (when (and complete_window_settings.fixed
                                                           (= (vim.fn.mode) :i))
                                                  (let [label vim_item.abbr
                                                        min_width complete_window_settings.min_width
                                                        max_width complete_window_settings.max_width
                                                        truncated_label (vim.fn.strcharpart label
                                                                                            0
                                                                                            max_width)]
                                                    (if (not (= truncated_label
                                                                label))
                                                        (set vim_item.abbr
                                                             (string.format "%s %s"
                                                                            truncated_label
                                                                            "…"))
                                                        (when (< (string.len label)
                                                                 min_width)
                                                          (let [padding (string.rep " "
                                                                                    (- min_width
                                                                                       (string.len label)))]
                                                            (set vim_item.abbr
                                                                 (string.format "%s %s"
                                                                                label
                                                                                padding)))))))
                                                vim_item))}}]
      (cmp.setup config_opts))
    (cmp.setup.cmdline "/" {:sources [{:name :buffer}]})
    (cmp.setup.cmdline "?" {:sources [{:name :buffer}]})
    (cmp.setup.cmdline ":"
                       {:sources (cmp.config.sources [{:name :path}
                                                      {:name :cmdline}])})
    (let [(ok resource) (pcall require :nvim-autopairs)]
      (if ok
          (let [cmp_autopairs (require :nvim-autopairs.completion.cmp)]
            (: cmp.event :on :confirm_done (cmp_autopairs.on_confirm_done)))))))

{: config}
