(local {: pack : map!} (require :lib))

(local packages ;; Helpers
       [;; (pack :zbirenbaum/copilot-cmp
        ;;       {:opts {:formatters {:insert_text (. (require :copilot_cmp.format) :remove_existing)}}
        ;;        :dependencies [(pack :zbirenbaum/copilot.lua
        ;;                             {:config #(let [copilot (require :copilot)]
        ;;                                         (copilot.setup {:filetypes {:yaml true
        ;;                                                                     :markdown true}
        ;;                                                         :suggestion {:enabled false}
        ;;                                                         :panel {:enabled false}}))})]})
        (pack :zbirenbaum/copilot.lua
              {:config #(let [copilot (require :copilot)]
                          (copilot.setup {:filetypes {:yaml true
                                                      :markdown true}
                                          :suggestion {:auto_trigger true
                                                       :keymap {:accept :<C-l>
                                                                :next :<C-n>
                                                                :prev :<C-p>
                                                                :dismiss :<C-k>}}
                                          :panel {:enabled false}}))})
        ; (pack :github/copilot.vim
        ;       {:config (fn []
        ;                  (set vim.g.copilot_filetypes
        ;                       {:markdown true :yaml true}))})
        ;;; Surround
        (pack :tpope/vim-surround {:config false})
        ;;; Autopairs
        (pack :windwp/nvim-autopairs (require :plugins.config.nvim-autopairs))
        ;; Comments
        (pack :numToStr/Comment.nvim (require :plugins.config.comment))
        ; ;; Heuristically set buffer options
        ; (pack :tpope/vim-sleuth {:config false})
        ;; Allignment
        (pack :junegunn/vim-easy-align
              {:config (fn []
                         (map! [:n] :ga "<Plug>(LiveEasyAlign)" {:noremap true}
                               "Align Block")
                         (map! [:x] :ga "<Plug>(LiveEasyAlign)" {:noremap true}
                               "Align Block"))})
        ;; Fix trailing whitespace
        (pack :ntpeters/vim-better-whitespace
              {:init (fn []
                       (set vim.g.better_whitespace_filetypes_blacklist
                            conf.ui-ft)
                       (set vim.g.better_whitespace_operator :<localleader>S)
                       (map! [:n] :<leader>cw :<cmd>StripWhitespace<cr> {}
                             "Strip Whitespaces"))})
        ;; Split/Join
        (pack :Wansmer/treesj (require :plugins.config.treesj))
        ;; Treesitter related
        (pack :nvim-treesitter/nvim-treesitter
              (require :plugins.config.treesitter))
        (pack :direnv/direnv.vim {:config false})])

(when conf.options.rainbow_parents
  (table.insert packages (pack :p00f/nvim-ts-rainbow {:config false})))

packages
