(local {: pack : map!} (require :lib))

(local handlers
       {:textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
                              {:border (if conf.options.float_border :rounded
                                           :none)})
        :textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help
                                      {:border (if conf.options.float_border
                                                   :rounded
                                                   :none)})})

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

(fn register-key [client bufnr telescope]
  (let [md {:silent false :buffer bufnr}]
    (when client.server_capabilities.codeActionProvider
      (map! [:n] :<leader>ca #(vim.lsp.buf.code_action) md
            "Show code action[LSP]"))
    (when client.server_capabilities.renameProvider
      (map! [:n] :<leader>cn #(vim.lsp.buf.rename) md "Variable renaming[LSP]"))
    ; (when client.server_capabilities.documentFormattingProvider
    (map! [:n] :<leader>cf #(vim.lsp.buf.format) md "Format buffer[LSP]") ; )
    (when client.server_capabilities.hoverProvider
      (do
        (map! [:n] :K #(vim.lsp.buf.hover) md "Show help information[LSP]")
        (map! [:n] :gh #(vim.lsp.buf.hover) md "Show help information[LSP]")))
    (when client.server_capabilities.referencesProvider
      (map! [:n] :gr #(telescope.lsp_references) md "Go to references[LSP]"))
    (when client.server_capabilities.implementationProvider
      (map! [:n] :gI #(telescope.lsp_implementations) md
            "Go to implementations[LSP]"))
    (when client.server_capabilities.definitionProvider
      (map! [:n] :gd #(telescope.lsp_definitions) md "Go to definitions[LSP]"))
    ;; TODO: fix
    ;; -- if client.resolved_capabilities.type_definition then
    ;; map("n", "gD", function()
    ;;     require("telescope.builtin").lsp_type_definitions()
    ;; end, _md, "Go to type definitions[LSP]")
    ;; -- end
    (when client.server_capabilities.declarationProvider
      (map! [:n] :gD #(telescope.lsp_declaration) md
            "Go to type definitions[LSP]"))
    (map! [:n] :gE #(telescope.diagnostics) md
          "Show Workspace Diagnostics[LSP]")
    (map! [:n] :ge
          #(vim.diagnostic.open_float {:border (if conf.options.float_border
                                                   :rounded
                                                   :none)}) md
          "Show Current Diagnostics[LSP]")
    (map! [:n] "[e"
          #(vim.diagnostic.goto_prev {:float {:border (if conf.options.float_border
                                                          :rounded
                                                          :none)}}) md
          "Jump to prev diagnostic[LSP]")
    (map! [:n] "]e"
          #(vim.diagnostic.goto_next {:float {:border (if conf.options.float_border
                                                          :rounded
                                                          :none)}}) md
          "Jump to next diagnostic[LSP]")))

(fn init []
  (map! [:n] :<leader>li :<cmd>LspInfo<CR> {:noremap true} :Info)
  (map! [:n] :<leader>ls :<cmd>LspStart<CR> {:noremap true} :Start)
  (map! [:n] :<leader>lS :<cmd>LspStop<CR> {:noremap true} :Stop)
  (map! [:n] :<leader>lr :<cmd>LspRestart<CR> {:noremap true} :Restart)
  (map! [:n] :<leader>ll :<cmd>LspLog<CR> {:noremap true} :Log))

(fn config []
  (let [lspconfig (require :lspconfig)
        mason_lspconfig (require :mason-lspconfig)
        navic (require :nvim-navic)
        telescope (require :telescope.builtin)]
    ;; Diagnostic config
    (vim.diagnostic.config {:signs true
                            :underline true
                            :severity_sort true
                            :update_in_insert false
                            :float {:border (if conf.options.float_border
                                                :rounded
                                                :none)
                                    :source :always}
                            :virtual_text {:prefix "●" :source :always}})
    ;; Signs
    (each [_type _icon (pairs conf.icons.diagnostic)]
      (let [hl (.. :DiagnosticSign _type)]
        (vim.fn.sign_define hl {:text _icon :texthl hl :numhl hl})))
    ;; Enriching capabilities
    (each [_ server_name (ipairs (mason_lspconfig.get_installed_servers))]
      (let [(ok got-settings) (pcall require
                                     (.. :plugins.lsp.servers. server_name))]
        (let [settings (if ok got-settings {})]
          (tset settings :capabilities capabilities)
          (tset settings :handlers
                (vim.tbl_deep_extend :force handlers
                                     (or got-settings.handlers {})))
          (tset settings :on_attach
                (fn [client bufnr]
                  (register-key client bufnr telescope)
                  (when client.server_capabilities.documentSymbolProvider
                    (navic.attach client bufnr))))
          ((. (. lspconfig server_name) :setup) settings))))))

(pack :neovim/nvim-lspconfig {: config : init :event [:BufReadPre :BufNewFile]})
