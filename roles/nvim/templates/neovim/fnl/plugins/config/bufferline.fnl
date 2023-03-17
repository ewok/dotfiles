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
  (map! :n :<leader>bp :<cmd>BufferLineTogglePin<cr> {:silent true}
        "Pin/Unpin current buffer")
  (for [i 1 9]
    (map! :n (.. :<leader> :b i) (.. "<cmd>BufferLineGoToBuffer " i :<cr>)
          {:silent true} (.. "Go to buffer " i))))

(fn config []
  (let [bufferline (require :bufferline)
        groups (require :bufferline.groups)]
    (bufferline.setup {:options {:themable true
                                 :numbers :none
                                 :buffer_close_icon ""
                                 :modified_icon "●"
                                 :diagnostics :nvim_lsp
                                 :color_icons true
                                 :indicator {:style :none}
                                 :show_buffer_close_icons false
                                 :show_close_icon false
                                 :show_tab_indicators true
                                 :sort_by :directory
                                 :persist_buffer_sort true
                                 :separator_style :slant
                                 :always_show_bufferline true
                                 :custom_areas {:right #[{:text (.. conf.separator.alt_right
                                                                    (string.gsub (vim.fn.getcwd)
                                                                                 conf.home-dir
                                                                                 "~"
                                                                                 1))
                                                          :fg conf.colors.base0D
                                                          :bg conf.colors.base00}]}
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
                                            :text_align :center}]
                                 :groups {:items [(groups.builtin.pinned:with {:icon "車"
                                                                               :name :pinned})
                                                  (groups.builtin.ungrouped:with {:sort_by :directory})]}}})))

{:event [:BufNewFile :BufRead :TabEnter] : config : init}
