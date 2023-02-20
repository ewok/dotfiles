(local {: path-join : exists?} (require :lib))

(local home-dir (os.getenv :HOME))
(local data-dir (vim.fn.stdpath :data))
(local config-dir (vim.fn.stdpath :config))
(local cache-dir (vim.fn.stdpath :cache))
(local notes-dir (path-join home-dir :Notes))

(local options {:transparent true
                :float_border true
                :transparent true
                :float_border true
                :download_source "https://github.com/"
                :snippets_directory (path-join config-dir :snippets)
                :auto_save true
                :auto_switch_input false
                :auto_restore_cursor_position true
                :auto_remove_new_lines_comment true
                :auto_toggle_rnu true
                :auto_hide_cursorline true
                :rainbow_parents false})


(local colors {:color_0 "#282c34"
               :color_1 "#e06c75"
               :color_2 "#98c379"
               :color_3 "#e5c07b"
               :color_4 "#61afef"
               :color_5 "#c678dd"
               :color_6 "#56b6c2"
               :color_7 "#abb2bf"
               :color_8 "#545862"
               :color_9 "#d19a66"
               :color_10 "#353b45"
               :color_11 "#3e4451"
               :color_12 "#565c64"
               :color_13 "#b6bdca"
               :color_14 "#be5046"
               :color_15 "#c8ccd4"})
               ; color_0 = "#{{@@ colors.color0 @@}}"
               ; color_1 = "#{{@@ colors.color1 @@}}",
               ; color_2 = "#{{@@ colors.color2 @@}}",
               ; color_3 = "#{{@@ colors.color3 @@}}",
               ; color_4 = "#{{@@ colors.color4 @@}}",
               ; color_5 = "#{{@@ colors.color5 @@}}",
               ; color_6 = "#{{@@ colors.color6 @@}}",
               ; color_7 = "#{{@@ colors.color7 @@}}",
               ; color_8 = "#{{@@ colors.color8 @@}}",
               ; color_9 = "#{{@@ colors.color9 @@}}",
               ; color_10 = "#{{@@ colors.color10 @@}}",
               ; color_11 = "#{{@@ colors.color11 @@}}",
               ; color_12 = "#{{@@ colors.color12 @@}}",
               ; color_13 = "#{{@@ colors.color13 @@}}",
               ; color_14 = "#{{@@ colors.color14 @@}}",
               ; color_15 = "#{{@@ colors.color15 @@}}",


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

(local ui-ft [""
              :aerial
              :qf
              :gitcommit
              :dbui
              :help
              :lspinfo
              :lsp-intaller
              :notify
              :NvimTre
              :packer
              :spectre_panel
              :startuptime
              :TelescopePrompt
              :TelescopResults
              :terminal
              :toggletem
              :undoree
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
                : ui-ft})
