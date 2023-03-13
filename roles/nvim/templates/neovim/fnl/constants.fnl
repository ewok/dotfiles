(local {: path-join : exists?} (require :lib))

(local home-dir (os.getenv :HOME))
(local data-dir (vim.fn.stdpath :data))
(local config-dir (vim.fn.stdpath :config))
(local cache-dir (vim.fn.stdpath :cache))
(local notes-dir (path-join home-dir :Notes))

(local options {:transparent true
                :float_border true
                :download_source "https://github.com/"
                :snippets_directory (path-join config-dir :snippets)
                :auto_save true
                :auto_switch_input false
                :auto_restore_cursor_position true
                :auto_remove_new_lines_comment true
                :auto_toggle_rnu true
                :auto_hide_cursorline true
                :rainbow_parents false
                ; :leap or :hop
                :motion_plugin :leap
                ;; bufferline or cokeline
                :bufferline_plugin :cokeline
                :theme "{{ theme.theme }}"})

(local separator {:left "{{ theme.separator_left }}"
                  :right "{{ theme.separator_right }}"
                  :alt_left "{{ theme.alt_separator_left }}"
                  :alt_right "{{ theme.alt_separator_right }}"})

; :color_0 "#282c34"
; :color_1 "#e06c75"
; :color_2 "#98c379"
; :color_3 "#e5c07b"
; :color_4 "#61afef"
; :color_5 "#c678dd"
; :color_6 "#56b6c2"
; :color_7 "#abb2bf"
; :color_8 "#545862"
; :color_9 "#d19a66"
; :color_10 "#353b45"
; :color_11 "#3e4451"
; :color_12 "#565c64"
; :color_13 "#b6bdca"
; :color_14 "#be5046"
; :color_15 "#c8ccd4"
(local colors {:base00 "#{{ colors.base00 }}"
               :base01 "#{{ colors.base01 }}"
               :base02 "#{{ colors.base02 }}"
               :base03 "#{{ colors.base03 }}"
               :base04 "#{{ colors.base04 }}"
               :base05 "#{{ colors.base05 }}"
               :base06 "#{{ colors.base06 }}"
               :base07 "#{{ colors.base07 }}"
               :base08 "#{{ colors.base08 }}"
               :base09 "#{{ colors.base09 }}"
               :base0A "#{{ colors.base0A }}"
               :base0B "#{{ colors.base0B }}"
               :base0C "#{{ colors.base0C }}"
               :base0D "#{{ colors.base0D }}"
               :base0E "#{{ colors.base0E }}"
               :base0F "#{{ colors.base0F }}"})

(local icons {})

(tset icons :platform {:unix "" :dos "" :mac ""})

(tset icons :diagnostic {:Error "" :Warn "" :Info "ﬤ" :Hint ""})

(tset icons :tag_level {:Fixme "ﰡ"
                        :Hack "ﰠ"
                        :Warn ""
                        :Note "ﮉ"
                        :Todo "ﮉ"
                        :Perf "ﮉ"})

(tset icons :lsp_kind {:String ""
                       :Number ""
                       :Boolean "◩"
                       :Array ""
                       :Object ""
                       :Key ""
                       :Null "ﳠ"
                       :Text ""
                       :Method ""
                       :Function ""
                       :Constructor ""
                       :Namespace ""
                       :Field "ﰠ"
                       :Variable "ﳋ"
                       :Class ""
                       :Interface ""
                       :Module "ﰪ"
                       :Property ""
                       :Unit "塞"
                       :Value ""
                       :Enum ""
                       :Keyword ""
                       :Snippet ""
                       :Color ""
                       :File ""
                       :Reference ""
                       :Folder ""
                       :EnumMember ""
                       :Constant ""
                       :Struct "﬌"
                       :Event ""
                       :Operator ""
                       :TypeParameter ""})

(local in-tmux? (exists? :$TMUX))

(local lisp-langs [:clojure
                   :common-lisp
                   :emacs-lisp
                   :lisp
                   :scheme
                   :timl
                   :edn
                   :fennel])

(local ui-ft [:aerial
              :gitcommit
              :dbui
              :help
              :lspinfo
              :lsp-intaller
              :notify
              :NvimTree
              :NvimTree_*
              :packer
              :spectre_panel
              :startuptime
              :TelescopePrompt
              :TelescopeResults
              :terminal
              :toggleterm
              :undotree
              :mind])

(tset _G :conf {: options
                : colors
                : icons
                : home-dir
                : data-dir
                : config-dir
                : cache-dir
                : notes-dir
                : in-tmux?
                : lisp-langs
                : separator
                : ui-ft})
