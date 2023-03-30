(local {: map! : umap!} (require :lib))

(fn open_callback [term]
  (map! :t :<C-J> "<c-\\><c-n><cmd>TmuxNavigateDown<cr>"
        {:silent true :buffer term.bufnr} :Down)
  (map! :t :<C-H> "<c-\\><c-n><cmd>TmuxNavigateLeft<cr>"
        {:silent true :buffer term.bufnr} :Left)
  (map! :t :<C-K> "<c-\\><c-n><cmd>TmuxNavigateUp<cr>"
        {:silent true :buffer term.bufnr} :Up)
  (map! :t :<C-L> "<c-\\><c-n><cmd>TmuxNavigateRight<cr>"
        {:silent true :buffer term.bufnr} :Right)
  (map! :n :<C-N> :i<C-N> {:silent true :buffer term.bufnr} :Next)
  (map! :n :<C-P> :i<C-P> {:silent true :buffer term.bufnr} :Previous)
  (map! :n :<C-C> :i<C-C> {:silent true :buffer term.bufnr} :Break)
  (map! :t :<C-U> "<c-\\><c-n><C-U>" {:silent true :buffer term.bufnr}
        :ScrollUp)
  (map! :t :<C-Y> "<c-\\><c-n><C-Y>" {:silent true :buffer term.bufnr}
        :ScrollOneUp)
  (map! :n :<CR> :i {:silent true :buffer term.bufnr} :Enter)
  (vim.cmd :startinsert))

(fn open_callback_float [term]
  (umap! :t :<esc>)
  (map! :t :<esc> "<c-\\><c-n><cmd>close<cr>" {:silent true :buffer term.bufnr}
        "Escape float terminal")
  (map! :n :<esc> :<cmd>close<cr> {:silent true :buffer term.bufnr} :Close)
  (open_callback term)
  (vim.cmd :startinsert))

; local function lazy_open_callback(term)
(fn open_callback_lazygit [term]
  (umap! :t :<esc>)
  (each [_ key (ipairs [:<c-cr> :<c-space>])]
    (map! [:t] key "<c-\\><c-n><cmd>close<cr>"
          {:silent true :buffer term.bufnr} "Escape lazygit terminal"))
  (map! [:i] :q :<cmd>close<cr> {:silent true :buffer term.bufnr}
        "Escape lazygit terminal")
  (vim.cmd :startinsert))

(fn close_callback []
  (map! :t :<esc> "<c-\\><c-n>" {:silent true} "Escape terminal insert mode"))

(fn config []
  (let [toggleterm (require :toggleterm)
        shell (if (= 1 (vim.fn.executable :fish)) :fish :bash)]
    (toggleterm.setup {:start_in_insert false
                       :shade_terminals true
                       :shading_factor -10
                       :persist_size false
                       :persist_mode false
                       :size (fn [term]
                               (if (= :horizontal (. term :direction))
                                   (* vim.o.lines 0.25)
                                   (* vim.o.columns 0.25)))
                       :on_open (fn [] (vim.wo.spell false))
                       :highlights {:Normal {:guibg conf.colors.base00}
                                    :NormalFloat {:link :NormalFloat}
                                    :FloatBorder {:link :FloatBorder}}
                       : shell})
    (let [terminal (require :toggleterm.terminal)
          terms terminal.Terminal
          horizontal-terminal #(let [horizontal (: terms :new
                                                   {:direction :horizontal
                                                    :count 110
                                                    :size (fn [term]
                                                            (if (= :horizontal
                                                                   (. term
                                                                      :direction))
                                                                (* vim.o.lines
                                                                   0.25)
                                                                (* vim.o.columns
                                                                   0.25)))
                                                    :on_open open_callback
                                                    :on_close close_callback})]
                                 (: horizontal :toggle nil :horizontal))
          float-terminal #(let [float (: terms :new
                                         {:hidden true
                                          :count 110
                                          :direction :float
                                          :float_opts {:border (if conf.options.float_border
                                                                   :rounded
                                                                   :none)}
                                          :on_open open_callback_float
                                          :on_close close_callback})]
                            (: float :toggle nil :float))]
      ;; Horizontal terminal at the bottom
      (map! :n :<leader>ot horizontal-terminal {:silent true}
            "Open bottom or vertical terminal")
      (map! [:n :t] :<c-space> horizontal-terminal {:silent true}
            "Toggle bottom or vertical terminal")
      ;; Float terminal
      (map! :n :<leader>of float-terminal {:silent true}
            "Open floating terminal")
      (map! [:n :t] :<c-cr> float-terminal {:silent true}
            "Toggle floating terminal")
      ;; Lazygit file history
      ;; (map! :n :<leader>glf #(let [lazygit (: terms :new
      ;;                                         {:cmd (.. "lazygit log -f "
      ;;                                                   (vim.fn.expand "%"))
      ;;                                          :hidden true
      ;;                                          :count 130
      ;;                                          :direction :float
      ;;                                          :float_opts {:border (if conf.options.float_border
      ;;                                                                   :rounded
      ;;                                                                   :none)}
      ;;                                          :on_open open_callback_lazygit
      ;;                                          :on_close close_callback})]
      ;;                          (: lazygit :toggle))
      ;;       {:silent true} "File history")
      ;; Lazygit
      (each [key info (pairs {;; :<leader>gg {:cmd "lazygit status"
                              ;;               :desc "Git status"
                              ;;               :count 140}
                              ;; :<leader>glL {:cmd "lazygit log"
                              ;;               :desc "Log"
                              ;;               :count 141}
                              :<leader>gg {:cmd :lazygit
                                           :desc "Git overall"
                                           :count 142}})]
        (map! :n key #(let [lazygit (: terms :new
                                       {:cmd info.cmd
                                        :hidden true
                                        :count info.count
                                        :direction :float
                                        :float_opts {:border (if conf.options.float_border
                                                                 :rounded
                                                                 :none)}
                                        :on_open open_callback_lazygit
                                        :on_close close_callback})]
                        (: lazygit :toggle))
              {:silent true} info.desc)))))

{: config}
