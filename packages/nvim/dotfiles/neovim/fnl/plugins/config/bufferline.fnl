(local {: map!} (require :lib))

(fn init []
  (map! :n :<C-W>d :<cmd>BufferDelete<cr> {:silent true} "Close current buffer")
  (map! :n :<C-W><C-D> :<cmd>BufferDelete<cr> {:silent true}
        "Close current buffer")
  (map! :n :<S-Tab> :<cmd>BufferLineCyclePrev<cr> {:silent true}
        "Go to left buffer")
  (map! :n :<Tab> :<cmd>BufferLineCycleNext<cr> {:silent true}
        "Go to right buffer")
  (map! :n :<leader>bn :<cmd>enew<cr> {:silent true} "Create new buffer")
  (map! :n :<leader>bh :<cmd>BufferLineCloseLeft<cr> {:silent true}
        "Close all left buffers")
  (map! :n :<leader>bl :<cmd>BufferLineCloseRight<cr> {:silent true}
        "Close all right buffers")
  (map! :n :<leader>bo
        (fn []
          (vim.cmd :BufferLineCloseLeft)
          (vim.cmd :BufferLineCloseRight)) {:silent true}
        "Close all other buffers")
  (map! :n :<leader>ba (fn []
                         (vim.cmd :BufferLineCloseLeft)
                         (vim.cmd :BufferLineCloseRight)
                         (vim.cmd :BufferDelete))
        {:silent true} "Close all buffers")
  (map! :n :<leader>bt :<cmd>BufferLinePick<cr> {:silent true} "Go to buffer *")
  (map! :n :<leader>bs :<cmd>BufferLineSortByDirectory<cr> {:silent true}
        "Buffers sort (by directory)")
  (map! :n :<leader>b1 "<cmd>BufferLineGoToBuffer 1<cr>" {:silent true}
        "Go to buffer 1")
  (map! :n :<leader>b2 "<cmd>BufferLineGoToBuffer 2<cr>" {:silent true}
        "Go to buffer 2")
  (map! :n :<leader>b3 "<cmd>BufferLineGoToBuffer 3<cr>" {:silent true}
        "Go to buffer 3")
  (map! :n :<leader>b4 "<cmd>BufferLineGoToBuffer 4<cr>" {:silent true}
        "Go to buffer 4")
  (map! :n :<leader>b5 "<cmd>BufferLineGoToBuffer 5<cr>" {:silent true}
        "Go to buffer 5")
  (map! :n :<leader>b6 "<cmd>BufferLineGoToBuffer 6<cr>" {:silent true}
        "Go to buffer 6")
  (map! :n :<leader>b7 "<cmd>BufferLineGoToBuffer 7<cr>" {:silent true}
        "Go to buffer 7")
  (map! :n :<leader>b8 "<cmd>BufferLineGoToBuffer 8<cr>" {:silent true}
        "Go to buffer 8")
  (map! :n :<leader>b9 "<cmd>BufferLineGoToBuffer 9<cr>" {:silent true}
        "Go to buffer 9"))

(fn config []
  (let [bufferline (require :bufferline)]
    (bufferline.setup {:options {:themable true
                                 :numbers :none
                                 :buffer_close_icon ""
                                 :modified_icon "●"
                                 :diagnostics :nvim_lsp
                                 ; :separator_style :slant
                                 :show_buffer_close_icons false
                                 :show_close_icon false
                                 :show_tab_indicators true
                                 :sort_by :directory
                                 :persist_buffer_sort true
                                 :always_show_bufferline true
                                 ;; TODO: Might not work either
                                 :diagnostics_indicator (fn [count
                                                             level
                                                             diagnostics_dict
                                                             context]
                                                          (let [message (match true
                                                                          diagnostics_dict.error (string.format "%s%s"
                                                                                                                conf.icons.Error
                                                                                                                diagnostics_dict.error)
                                                                          diagnostics_dict.warning (string.format "%s%s"
                                                                                                                  conf.icons.Warn
                                                                                                                  diagnostics_dict.warning)
                                                                          diagnostics_dict.info (string.format "%s%s"
                                                                                                               conf.icons.Info
                                                                                                               diagnostics_dict.info)
                                                                          diagnostics_dict.hint (string.format "%s%s"
                                                                                                               conf.icons.Hint
                                                                                                               diagnostics_dict.hint)
                                                                          _ "")]
                                                            message))
                                 :custom_areas {:right #[{:text (string.gsub (vim.fn.getcwd)
                                                                             conf.home-dir
                                                                             "~"
                                                                             1)
                                                          :guifg conf.colors.color_4
                                                          :guibg conf.colors.color_0}]}
                                 :offsets [{:filetype :NvimTree
                                            :text "File Explorer"
                                            :highlight :Directory
                                            :text_align :center}
                                           {:filetype :aerial
                                            :text "Outline Explorer"
                                            :highlight :Directory
                                            :text_align :center}
                                           {:filetype :undotree
                                            :text "Undo Explorer"
                                            :highlight :Directory
                                            :text_align :center}
                                           {:filetype :dbui
                                            :text "Database Explorer"
                                            :highlight :Directory
                                            :text_align :center}
                                           {:filetype :spectre_panel
                                            :text "Project Blurry Search"
                                            :highlight :Directory
                                            :text_align :center}
                                           {:filetype :toggleterm
                                            :text "Integrated Terminal"
                                            :highlight :Directory
                                            :text_align :center}
                                           {:filetype :mind
                                            :text "Mind Map"
                                            :highlight :Directory
                                            :text_align :center}]}})))

{:event [:BufNewFile :BufRead :TabEnter] : config : init}
