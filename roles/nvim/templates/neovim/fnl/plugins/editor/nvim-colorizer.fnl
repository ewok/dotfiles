;; Colorizer
(local {: pack : map!} (require :lib))

(pack :norcalli/nvim-colorizer.lua
      {:event [:InsertEnter]
       :config #(map! [:n] :<leader>tc :<cmd>ColorizerToggle<cr> {:silent true}
                      "Code Colorizer")})
