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
                ;; bufferline or cokeline or tabby or tabline
                :bufferline_plugin :tabline
                :theme "{{ conf.theme.theme }}"
                :spelllang [:nospell :en_us :ru_ru]
                :large_file_size (* 1024 1024 20)})

(local separator
       {:left "{{ conf.theme.separator_left }}"
        :right "{{ conf.theme.separator_right }}"
        :alt_left "{{ conf.theme.alt_separator_left }}"
        :alt_right "{{ conf.theme.alt_separator_right }}"})

(local colors {:base00 "#{{ conf.colors.base00 }}"
               :base01 "#{{ conf.colors.base01 }}"
               :base02 "#{{ conf.colors.base02 }}"
               :base03 "#{{ conf.colors.base03 }}"
               :base04 "#{{ conf.colors.base04 }}"
               :base05 "#{{ conf.colors.base05 }}"
               :base06 "#{{ conf.colors.base06 }}"
               :base07 "#{{ conf.colors.base07 }}"
               :base08 "#{{ conf.colors.base08 }}"
               :base09 "#{{ conf.colors.base09 }}"
               :base0A "#{{ conf.colors.base0A }}"
               :base0B "#{{ conf.colors.base0B }}"
               :base0C "#{{ conf.colors.base0C }}"
               :base0D "#{{ conf.colors.base0D }}"
               :base0E "#{{ conf.colors.base0E }}"
               :base0F "#{{ conf.colors.base0F }}"})

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
