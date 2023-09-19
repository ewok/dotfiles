;; Split/Join
(local {: pack : map!} (require :lib))

(fn config []
  (let [treesj (require :treesj)]
    (map! [:n] :g<space> :<cmd>TSJToggle<cr> {:noremap true}
          "Toggle Split/Join")
    (map! [:n] :gs :<cmd>TSJSplit<cr> {:noremap true} "Split blocks")
    (map! [:n] :gj :<cmd>TSJJoin<cr> {:noremap true} "Join blocks")
    (treesj.setup {:use_default_keymaps false})))

(pack :Wansmer/treesj {: config :event [:InsertEnter]})
