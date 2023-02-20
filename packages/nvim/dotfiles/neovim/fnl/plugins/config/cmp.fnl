;; local function under_compare(entry1, entry2)
;;     -- decrease priority if suggestion starts with _
;;     local _, entry1_under = entry1.completion_item.label:find("^_+")
;;     local _, entry2_under = entry2.completion_item.label:find("^_+")
;;
;;     entry1_under = entry1_under or 0
;;     entry2_under = entry2_under or 0
;;
;;     return entry1_under < entry2_under
;; end
;;
;; local function toggle_sidebar(target_ft)
;;     local offset_ft = {
;;         "NvimTree",
;;         "undotree",
;;         "dbui",
;;         "spectre_panel",
;;         "mind",
;;     }
;;     for _, opts in ipairs(get_all_win_buf_ft()) do
;;         if opts.buf_ft ~= target_ft and vim.tbl_contains(offset_ft, opts.buf_ft) then
;;             vim.api.nvim_win_close(opts.win_id, true)
;;         end
;;     end
;; end

(local complete_window_settings {:fixed true :min_width 20 :max_width 40})

;; local duplicate_keywords = {
;;     -- allow duplicate keywords
;;     ["vsnip"] = 1,
;;     ["nvim_lsp"] = 1,
;;     -- do not allow duplicate keywords
;;     ["buffer"] = 0,
;;     ["path"] = 0,
;;     ["cmdline"] = 0,
;;     ["vim-dadbod-completion"] = 0,
;;     ["conjure"] = 0,
;; }
(local duplicate_keywords {"vsnip" 1})

(fn config []
  (let [
cmp (require :cmp)
types (require :cmp.types)
        ]


  (cmp.setup {:preselect types.cmp.PreselectMode.None
        :confirmation {:default_behavior cmp.ConfirmBehavior.Insert}
        :snippet {:expand (fn [args]
                            (vim.call "vsnip#anonymous" args.body))}
        :sources (cmp.config.sources [{:name :calc}
                                      {:name :vsnip}
                                      {:name :nvim_lsp}
                                      {:name :conjure}
                                      {:name :path}
                                      {:name :buffer}
                                      {:name :vim-dadbod-completion}])
        :mapping {:<cr> (cmp.mapping (cmp.mapping.confirm) [:i :s :c])
                  :<c-p> (cmp.mapping (cmp.mapping.select_prev_item) [:i :s :c])
                  :<c-n> (cmp.mapping (cmp.mapping.select_next_item) [:i :s :c])
                  :<c-b> (cmp.mapping (cmp.mapping.scroll_docs -5) [:i :s :c])
                  :<c-f> (cmp.mapping (cmp.mapping.scroll_docs 5) [:i :s :c])
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
                                ;; TODO: implement function on the top
                                ;; under_compare
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
                                                     (. conf.icons kind) kind))
                                 (set vim_item.menu
                                      (string.format "<%s>"
                                                     (string.upper source)))
                                 (set vim_item.dup
                                      (or (. duplicate_keywords source) 0))
                                 ;; if complete_window_settings.fixed and vim.fn.mode() == "i" then
                                 (when (and complete_window_settings.fixed
                                            (= (vim.fn.mode) :i))
                                   (let [label vim_item.abbr
                                         min_width complete_window_settings.min_width
                                         max_width complete_window_settings.max_width
                                         truncated_label (vim.fn.strcharpart label
                                                                             0
                                                                             max_width)]
                                     (if (not (= truncated_label label))
                                         (set vim_item.abbr
                                              (string.format "%s %s"
                                                             truncated_label
                                                             "…"))
                                         (when (< (string.len label) min_width)
                                           (let [padding (string.rep " "
                                                                     (- min_width
                                                                        (string.len label)))]
                                             (set vim_item.abbr
                                                  (string.format "%s %s" label
                                                                 padding)))))))
                                 vim_item))}})

  (cmp.setup.cmdline "/" {:sources [{:name "buffer"}]})
  (cmp.setup.cmdline "?" {:sources [{:name "buffer"}]})
  (cmp.setup.cmdline ":" {:sources (cmp.config.sources [{:name "path"}
                                                               {:name "cmdline"}])})
  (let [(ok resource) (pcall require :nvim-autopairs)]
    (if ok
      (let [cmp_autopairs (require :nvim-autopairs.completion.cmp)]
        (cmp.event:on "confirm_done" (cmp_autopairs.on_confirm_done)))))
  ))
    ;; FIX: Renders to this, might not work
    ;; return (cmp.event):on("confirm_done", cmp_autopairs.on_confirm_done())

{: config}
