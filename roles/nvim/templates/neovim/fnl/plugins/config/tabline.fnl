(local {: map! : close_sidebar} (require :lib))

(local buff_hint "^^     Buffers           ^^     Tabs
 ^^---------------        ^^---------------
 _l_, _h_: next/previous  ^^ _L_, _H_: next/previous
 _d_: delete              ^^ _D_: delete
 _a_: new                 ^^ _A_: new
 _o_: remain only         ^^ _O_: remain only

 any : quit
 ")

(fn init []
  (map! :n :<C-W>d "<cmd>lua require('scope.core').delete_buffer()<cr>"
        {:silent true} "Close current buffer")
  (map! :n :<C-W><C-D> "<cmd>lua require('scope.core').delete_buffer()<cr>"
        {:silent true} "Close current buffer"))

(fn find-file [nvim-tree-api]
  (let [win (vim.api.nvim_get_current_win)]
    (nvim-tree-api.tree.find_file {:open true :focus false})))

(fn config []
  (let [tabline (require :tabline)
        hydra (require :hydra)
        nvim-tree-api (require :nvim-tree.api)
        scope (require :scope.core)]
    (tabline.setup {:enable true
                    :options {:show_tabs_always true
                              :show_devicons true
                              :show_filename_only true
                              :modified_italic true}})
    (let [buff_tabs (hydra {:name :Buffers/Tabs
                            :hint buff_hint
                            :config {:hint {:border :rounded}
                                     :on_exit #(close_sidebar :NvimTree)
                                     :on_enter #(do
                                                  ; (vim.cmd :NvimTreeOpen)
                                                  (find-file nvim-tree-api))
                                     :on_key #(find-file nvim-tree-api)}
                            ; :mode :n
                            ; :body :<leader>b
                            :heads [[:<Tab> #(vim.cmd :TablineBufferNext)]
                                    [:<S-Tab>
                                     #(vim.cmd :TablineBufferPrevious)]
                                    [:l #(vim.cmd :TablineBufferNext)]
                                    [:h #(vim.cmd :TablineBufferPrevious)]
                                    [:d #(scope.delete_buffer) {:desc :delete}]
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
      (map! :n :<S-Tab> #(do
                           (vim.cmd :TablineBufferPrevious)
                           (: buff_tabs :activate)) {}
            :Buffers/Tabs)
      (map! :n :<Tab> #(do
                         (vim.cmd :TablineBufferNext)
                         (: buff_tabs :activate)) {}
            :Buffers/Tabs))))

{: config : init}
