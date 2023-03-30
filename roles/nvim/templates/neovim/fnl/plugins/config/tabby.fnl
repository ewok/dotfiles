(local {: map!} (require :lib))

(fn tab_label [tabid active util]
  (let [icon (if active "" "")
        number (vim.api.nvim_tabpage_get_number tabid)
        name (util.get_tab_name tabid)]
    (string.format " %s %d: %s " icon number name)))

(fn preset [util]
  (let [hl_tabline_fill (util.extract_nvim_hl :TabLineFill)
        hl_tabline (util.extract_nvim_hl :Title)
        hl_tabline_sel (util.extract_nvim_hl :TabLineSel)]
    {:hl :TabLineFill
     :head [["  " {:hl {:fg hl_tabline.fg :bg hl_tabline.bg}}]
            ["" {:hl {:fg hl_tabline.bg :bg hl_tabline_fill.bg}}]]
     :active_tab {:label #[(tab_label $1 true util)
                           {:hl {:fg hl_tabline_sel.fg
                                 :bg hl_tabline_sel.bg
                                 :style :bold}}]
                  :left_sep [conf.separator.right
                             {:hl {:fg hl_tabline_sel.bg
                                   :bg hl_tabline_fill.bg}}]
                  :right_sep [conf.separator.left
                              {:hl {:bg hl_tabline_sel.bg
                                    :fg hl_tabline_fill.bg}}]}
     :inactive_tab {:label #[(tab_label $1 false util)
                             {:hl {:fg :hl_tabline.fg :bg :hl_tabline_fill.bg}}]
                    :left_sep [" "
                               {:hl {:fg hl_tabline.bg :bg hl_tabline_fill.bg}}]
                    :right_sep [" "
                                {:hl {:fg hl_tabline.bg :bg hl_tabline_fill.bg}}]}}))

(fn config []
  (let [util (require :tabby.util)
        tabline (require :tabby.tabline)
        preset (preset util)]
    ;; (tabline.use_preset :active_wins_at_end {
    ;;                     :theme theme
    ;;                     :nerdfont true
    ;;                     ; :tab_name {:name_fallback "function({tabid}), return a string"}
    ;;                     ; :buf_name {:mode "'unique'|'relative'|'tail'|'shorten'"}
    ;;                     })
    (tabline.set (fn [line]
                   [preset.head
                    (let [tabs (line.tabs)]
                      (tabs.foreach (fn [tab]
                                      (if (tab.is_current)
                                          [preset.active_tab.left_sep
                                           (preset.active_tab.label tab.id)
                                           preset.active_tab.right_sep
                                           {:hl preset.hl}
                                           {:margin " "}]
                                          [preset.inactive_tab.left_sep
                                           (preset.inactive_tab.label tab.id)
                                           preset.inactive_tab.right_sep
                                           {:hl preset.hl}
                                           {:margin " "}])
                                      ; (let [hl (if (tab.is_current) ;              theme.current_tab ;              theme.tab)] ;   [(line.sep conf.separator.right hl ;              theme.fill) ;    (if (tab.is_current) "" "") ;    (tab.number) ;    (tab.name) ;    (tab.close_btn "") ;    (line.sep conf.separator.left hl ;              theme.fill) ;    {:hl preset.hl} ;    {:margin " "}])
                                      )))
                    (line.spacer)
                    ; (let [wins (line.wins_in_tab (line.api.get_current_tab))]
                    ;   (wins.foreach (fn [win]
                    ;                   [(line.sep conf.separator.right theme.win
                    ;                              theme.fill)
                    ;                    (if (win.is_current) "" "")
                    ;                    (win.buf_name)
                    ;                    (line.sep conf.separator.left theme.win
                    ;                              theme.fill)
                    ;                    {:hl theme.win}
                    ;                    {:margin " "}])))
                    ; [(line.sep conf.separator.right theme.tail theme.fill)
                    ;  ["  " {:hl theme.tail}]]
                    ; {:hl theme.fill}
                    ]))))

{: config}
