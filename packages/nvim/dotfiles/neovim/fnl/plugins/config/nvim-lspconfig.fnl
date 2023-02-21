(local {: map!} (require :lib))

(local capabilities (let [c (vim.lsp.protocol.make_client_capabilities)]
                      (set c.textDocument.completion.completionItem
                           {:documentationFormat [:markdown :plaintext]
                            :snippetSupport true
                            :preselectSupport true
                            :insertReplaceSupport true
                            :labelDetailsSupport true
                            :deprecatedSupport true
                            :commitCharactersSupport true
                            :tagSupport {:valueSet [1]}
                            :resolveSupport {:properties [:documentation
                                                          :detail
                                                          :additionalTextEdits]}})
                      c))

(fn register-key [client bufnr]
  (let [md {:silent false :buffer bufnr}]
    (when client.server_capabilities.codeActionProvider
      (map! [:n] :<leader>ca #(vim.lsp.buf.code_action) md
            "Show code action[LSP]"))
    (when client.server_capabilities.renameProvider
      (map! [:n] :<leader>cn #(vim.lsp.buf.rename) md "Variable renaming[LSP]"))
    (when client.server_capabilities.documentFormattingProvider
      (map! [:n] :<leader>cf #(vim.lsp.buf.format) md "Format buffer[LSP]"))
    (when client.server_capabilities.hoverProvider
      (map! [:n] :K #(vim.lsp.buf.hover) md "Show help information[LSP]"))
    (when client.server_capabilities.referencesProvider
      (map! [:n] :gr #(. (require :telescope.builtin) :lsp_references) md
            "Go to references[LSP]"))
    (when client.server_capabilities.implementationProvider
      (map! [:n] :gI #(. (require :telescope.builtin) :lsp_implementations) md
            "Go to implementations[LSP]"))
    (when client.server_capabilities.definitionProvider
      (map! [:n] :gd #(. (require :telescope.builtin) :lsp_definitions) md
            "Go to definitions[LSP]"))
    ;; TODO: fix
    ;; -- if client.resolved_capabilities.type_definition then
    ;; map("n", "gD", function()
    ;;     require("telescope.builtin").lsp_type_definitions()
    ;; end, _md, "Go to type definitions[LSP]")
    ;; -- end
    (when client.server_capabilities.declarationProvider
      (map! [:n] :gD #(. (require :telescope.builtin) :lsp_declaration) md
            "Go to type definitions[LSP]"))
    (map! [:n] :gO #(. (require :telescope.builtin) :diagnostics) md
          "Show Workspace Diagnostics[LSP]")
    (map! [:n] :go
          #(vim.diagnostic.open_float {:border (if conf.options.float_border
                                                   :rounded
                                                   :none)}) md
          "Show Current Diagnostics[LSP]")
    (map! [:n] "[d"
          #(vim.diagnostic.goto_prev {:float {:border (if conf.options.float_border
                                                          :rounded
                                                          :none)}}) md
          "Jump to prev diagnostic[LSP]")
    (map! [:n] "]d"
          #(vim.diagnostic.goto_next {:float {:border (if conf.options.float_border
                                                          :rounded
                                                          :none)}}) md
          "Jump to next diagnostic[LSP]")
    ;; TODO: Not finished yet
    ;     map("i", "<c-b>", scroll_to_up, _md, "Scroll up floating window[LSP]")
    ;     map("i", "<c-f>", scroll_to_down, _md, "Scroll down floating window[LSP]")
    ;     map("i", "<c-]>", focus_float_window(), _md, "Focus floating window[LSP]")
    ;     -- if client.resolved_capabilities.signature_help then ;     map("i", "<c-j>", sigature_help, _md, "Toggle signature help[LSP]")
    ))

(fn init []
  (map! [:n] :<leader>li :<cmd>LspInfo<CR> {:noremap true} :Info)
  (map! [:n] :<leader>ls :<cmd>LspStart<CR> {:noremap true} :Start)
  (map! [:n] :<leader>lS :<cmd>LspStop<CR> {:noremap true} :Stop)
  (map! [:n] :<leader>lr :<cmd>LspRestart<CR> {:noremap true} :Restart)
  (map! [:n] :<leader>ll :<cmd>LspLog<CR> {:noremap true} :Log))

(fn config []
  (let [lspconfig (require :lspconfig)
        mason_lspconfig (require :mason-lspconfig)]
    (vim.diagnostic.config {:signs true
                            :underline true
                            :severity_sort true
                            :update_in_insert false
                            :float {:source :always}
                            :virtual_text {:prefix "●" :source :always}}
                           (each [_ server_name (ipairs (mason_lspconfig.get_installed_servers))]
                             (let [(ok settings) (pcall require
                                                        (.. :plugins.config.servers.
                                                             server_name))]
                               (let [settings (if ok settings {})]
                                 (tset settings :capabilities capabilities)
                                 (tset settings :handlers
                                       (or settings.handlers {}))
                                 (tset settings :on_attach
                                       (fn [client bufnr]
                                         (register-key client bufnr)))
                                 ((. (. lspconfig server_name) :setup) settings)))))))

;; TODO: Not finished yet
;; -- lspconfig float window set border
;; local win = require("lspconfig.ui.windows")
;; local _default_opts = win.default_opts
;; ---@diagnostic disable-next-line: redefined-local
;; win.default_opts = function(opts)
;;     local default_opts1 = _default_opts(opts)
;;     default_opts1.border = options.float_border and "double" or "none"
;;     return default_opts1
;; end
;; -- }}}

{: config : init}
