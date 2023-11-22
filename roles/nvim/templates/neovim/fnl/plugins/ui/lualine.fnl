; ;; Lualine
(local {: pack : map! : close_sidebar} (require :lib))

(local buff_hint "^^             Buffers           ^^     Tabs
 ^^---------------                ^^---------------
 _l_, _h_: next/previous          ^^ _L_, _H_: next/previous
 _d_: delete                      ^^ _D_: delete
 _a_: new                         ^^ _A_: new
 _o_: remain only                 ^^ _O_: remain only

 any : quit
 ")

(fn init []
  (map! :n :<C-W>d "<cmd>lua require('scope.core').delete_buf()<cr>"
        {:silent true} "Close current buffer")
  (map! :n :<C-W><C-D> "<cmd>lua require('scope.core').delete_buf()<cr>"
        {:silent true} "Close current buffer"))

(fn find-file [nvim-tree-api]
  (let [win (vim.api.nvim_get_current_win)]
    (nvim-tree-api.tree.find_file {:open true :focus false})))

(fn config []
  (let [lualine (require :lualine)
        hydra (require :hydra)
        nvim-tree-api (require :nvim-tree.api)
        scope (require :scope.core)]
    (lualine.setup {:options {:theme (or conf.options.theme :auto)
                              :icons_enabled true
                              :component_separators {:left conf.separator.alt_left
                                                     :right conf.separator.alt_right}
                              :section_separators {:left conf.separator.left
                                                   :right conf.separator.right}
                              :disabled_filetypes []
                              :globalstatus true
                              :refresh {:statusline 100
                                        :tabline 100
                                        :winbar 100}}
                    :sections {:lualine_a [:mode]
                               :lualine_b [:branch :diff :diagnostics]
                               :lualine_c [:filename]
                               :lualine_x [:encoding
                                           :fileformat
                                           :filetype
                                           ;; Adding Yaml Companion result
                                           (fn []
                                             (let [yc (require :yaml-companion)
                                                   schema (yc.get_buf_schema 0)]
                                               (if (= (. schema :result 1 :name)
                                                      :none)
                                                   ""
                                                   (. schema :result 1 :name))))]
                               :lualine_y [:progress]
                               :lualine_z [:location]}
                    :tabline {:lualine_a [:buffers]
                              :lualine_b []
                              :lualine_c []
                              :lualine_x []
                              :lualine_y [:tabs]
                              :lualine_z ["string.gsub(vim.fn.getcwd(), os.getenv('HOME'), '~')"]}})
    (let [buff_tabs (hydra {:name :Buffers/Tabs
                            :hint buff_hint
                            :config {:hint {:border :rounded}
                                     :on_exit #(close_sidebar :NvimTree)
                                     :on_enter #(do
                                                  ; (vim.cmd :NvimTreeOpen)
                                                  (find-file nvim-tree-api))
                                     :on_key #(do
                                                (find-file nvim-tree-api)
                                                (lualine.refresh {:scope :tabpage
                                                                  :place [:tabline
                                                                          :statusline
                                                                          :winbar]}))}
                            ; :mode :n
                            ; :body :<leader>b
                            :heads [[:<Tab> #(vim.cmd :bn)]
                                    [:<S-Tab> #(vim.cmd :bp)]
                                    [:l #(vim.cmd :bn)]
                                    [:h #(vim.cmd :bp)]
                                    [:d #(scope.delete_buf) {:desc :delete}]
                                    [:a
                                     #(vim.cmd :enew)
                                     {:desc :new :exit true}]
                                    [:o
                                     #(vim.cmd :BufOnly)
                                     {:desc :only :exit true}]
                                    [:L #(vim.cmd :tabnext)]
                                    [:H #(vim.cmd :tabprevious)]
                                    [:D #(vim.cmd :tabclose) {:desc :delete}]
                                    [:A
                                     #(vim.cmd :$tabnew)
                                     {:desc :new :exit true}]
                                    [:O
                                     #(vim.cmd :tabonly)
                                     {:desc :only :exit true}]]})]
      (map! :n :<leader>b #(: buff_tabs :activate) {} :Buffers/Tabs)
      (map! :n :<S-Tab>
            #(do
               (vim.cmd :bp)
               (: buff_tabs :activate)
               (lualine.refresh {:scope :tabpage
                                 :place [:tabline :statusline :winbar]}))
            {} :Buffers/Tabs)
      (map! :n :<Tab>
            #(do
               (vim.cmd :bn)
               (: buff_tabs :activate)
               (lualine.refresh {:scope :tabpage
                                 :place [:tabline :statusline :winbar]}))
            {} :Buffers/Tabs))))

(pack :nvim-lualine/lualine.nvim {: config : init})
