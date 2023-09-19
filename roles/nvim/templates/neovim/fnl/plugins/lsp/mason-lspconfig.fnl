(local {: pack} (require :lib))

(pack :williamboman/mason-lspconfig.nvim {:config false :event [:BufReadPre :BufNewFile]})
