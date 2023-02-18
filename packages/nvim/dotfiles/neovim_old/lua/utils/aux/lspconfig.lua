local public = require("utils.public")
local options = require("core.options")
local setting = require("core.setting")
local icons = public.get_icons("diagnostic", true)
local map = require("utils.api").map.map

local aux_lspconfig = {}

function aux_lspconfig.lsp_hover(_, result, ctx, config)
    -- add file type for LSP hover
    local bufnr, winner = vim.lsp.handlers.hover(_, result, ctx, config)

    if bufnr and winner then
        vim.api.nvim_buf_set_option(bufnr, "filetype", config.filetype)
        return bufnr, winner
    end
end

function aux_lspconfig.lsp_signature_help(_, result, ctx, config)
    -- add file type for LSP signature help
    local bufnr, winner = vim.lsp.handlers.signature_help(_, result, ctx, config)

    -- put the signature floating window above the cursor
    local current_cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local ok, win_height = pcall(vim.api.nvim_win_get_height, winner)

    if not ok then
        return
    end

    if current_cursor_line > win_height + 2 then
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.api.nvim_win_set_config(winner, {
            anchor = "SW",
            relative = "cursor",
            row = 0,
            col = -1,
        })
    end

    if bufnr and winner then
        vim.api.nvim_buf_set_option(bufnr, "filetype", config.filetype)
        return bufnr, winner
    end
end

function aux_lspconfig.basic_quick_set()
    aux_lspconfig.lsp_handlers = {
        ["textDocument/hover"] = vim.lsp.with(aux_lspconfig.lsp_hover, {
            border = options.float_border and "rounded" or "none",
            filetype = "lsp-hover",
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(aux_lspconfig.lsp_signature_help, {
            border = options.float_border and "rounded" or "none",
            filetype = "lsp-signature-help",
        }),
    }

    aux_lspconfig.capabilities = vim.lsp.protocol.make_client_capabilities()

    aux_lspconfig.capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
            },
        },
    }
end

function aux_lspconfig.diagnostic_quick_set()
    -- set diagnostic style
    vim.diagnostic.config({
        signs = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false,
        float = { source = "always" },
        virtual_text = { prefix = "●", source = "always" },
    })

    for _type, icon in pairs(icons) do
        local hl = "DiagnosticSign" .. _type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

function aux_lspconfig.lspconfig_ui_quick_set()
    -- lspconfig float window set border
    local win = require("lspconfig.ui.windows")
    local _default_opts = win.default_opts

    ---@diagnostic disable-next-line: redefined-local
    win.default_opts = function(opts)
        local default_opts = _default_opts(opts)
        default_opts.border = options.float_border and "double" or "none"
        return default_opts
    end
end

function aux_lspconfig.get_headlers(settings)
    return vim.tbl_deep_extend("force", aux_lspconfig.lsp_handlers, settings.handlers or {})
end

function aux_lspconfig.get_capabilities()
    return aux_lspconfig.capabilities
end

-- goto diagnostic
aux_lspconfig.diagnostic_open_float = function()
    vim.diagnostic.open_float({ border = options.float_border and "rounded" or "none" })
end

aux_lspconfig.goto_next_diagnostic = function()
    vim.diagnostic.goto_next({ float = { border = options.float_border and "rounded" or "none" } })
end

aux_lspconfig.goto_prev_diagnostic = function()
    vim.diagnostic.goto_prev({ float = { border = options.float_border and "rounded" or "none" } })
end

function aux_lspconfig.sigature_help()
    -- When the signature is visible, pressing <c-j> again will close the window
    for _, opts in ipairs(public.get_all_win_buf_ft()) do
        if opts.buf_ft == "lsp-signature-help" then
            vim.api.nvim_win_close(opts.win_id, false)
            return
        end
    end
    vim.lsp.buf.signature_help()
end

function aux_lspconfig.scroll_to_up()
    local scroll_floating_filetype = { "lsp-signature-help", "lsp-hover" }

    for _, opts in ipairs(public.get_all_win_buf_ft()) do
        if vim.tbl_contains(scroll_floating_filetype, opts.buf_ft) then
            local win_height = vim.api.nvim_win_get_height(opts.win_id)
            local cursor_line = vim.api.nvim_win_get_cursor(opts.win_id)[1]
            local buf_total_line = vim.api.nvim_buf_line_count(opts.buf_id)
            ---@diagnostic disable-next-line: redundant-parameter
            local win_first_line = vim.fn.line("w0", opts.win_id)

            if buf_total_line <= win_height or cursor_line == 1 then
                vim.api.nvim_echo({ { "Can't scroll up", "MoreMsg" } }, false, {})
                return
            end

            vim.opt.scrolloff = 0
            if cursor_line > win_first_line then
                if win_first_line - 5 > 1 then
                    vim.api.nvim_win_set_cursor(opts.win_id, { win_first_line - 5, 0 })
                else
                    vim.api.nvim_win_set_cursor(opts.win_id, { 1, 0 })
                end
            elseif cursor_line - 5 < 1 then
                vim.api.nvim_win_set_cursor(opts.win_id, { 1, 0 })
            else
                vim.api.nvim_win_set_cursor(opts.win_id, { cursor_line - 5, 0 })
            end
            vim.opt.scrolloff = setting.opt.scrolloff

            return
        end
    end

    local map = "<c-b>"
    local key = vim.api.nvim_replace_termcodes(map, true, false, true)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_feedkeys(key, "n", true)
end

function aux_lspconfig.scroll_to_down()
    local scroll_floating_filetype = { "lsp-signature-help", "lsp-hover" }

    for _, opts in ipairs(public.get_all_win_buf_ft()) do
        if vim.tbl_contains(scroll_floating_filetype, opts.buf_ft) then
            local win_height = vim.api.nvim_win_get_height(opts.win_id)
            local cursor_line = vim.api.nvim_win_get_cursor(opts.win_id)[1]
            local buf_total_line = vim.api.nvim_buf_line_count(opts.buf_id)
            ---@diagnostic disable-next-line: redundant-parameter
            local win_last_line = vim.fn.line("w$", opts.win_id)

            if buf_total_line <= win_height or cursor_line == buf_total_line then
                vim.api.nvim_echo({ { "Can't scroll down", "MoreMsg" } }, false, {})
                return
            end

            vim.opt.scrolloff = 0

            if cursor_line < win_last_line then
                if win_last_line + 5 < buf_total_line then
                    vim.api.nvim_win_set_cursor(opts.win_id, { win_last_line + 5, 0 })
                else
                    vim.api.nvim_win_set_cursor(opts.win_id, { buf_total_line, 0 })
                end
            elseif cursor_line + 5 >= buf_total_line then
                vim.api.nvim_win_set_cursor(opts.win_id, { buf_total_line, 0 })
            else
                vim.api.nvim_win_set_cursor(opts.win_id, { cursor_line + 5, 0 })
            end
            vim.opt.scrolloff = setting.opt.scrolloff

            return
        end
    end

    local map = "<c-f>"
    local key = vim.api.nvim_replace_termcodes(map, true, false, true)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_feedkeys(key, "n", true)
end

function aux_lspconfig.focus_float_window()
    local prev_win = {}

    return function()
        if not vim.tbl_isempty(prev_win) and vim.api.nvim_win_is_valid(prev_win.id) then
            vim.fn.win_gotoid(prev_win.id)
            vim.api.nvim_win_set_cursor(prev_win.id, prev_win.cursor)
            if prev_win.mode == "i" then
                vim.cmd([[startinsert]])
            end
            prev_win = {}
            return
        end

        for _, float_win in ipairs(public.get_all_float_win()) do
            local mode = vim.fn.mode()

            prev_win = {
                id = vim.fn.win_getid(),
                cursor = vim.api.nvim_win_get_cursor(0),
                mode = mode,
            }

            vim.fn.win_gotoid(float_win.id)

            if mode == "i" then
                vim.cmd([[stopinsert]])
            end

            return
        end

        local map = "<c-]>"
        local key = vim.api.nvim_replace_termcodes(map, true, false, true)
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.api.nvim_feedkeys(key, "n", true)
    end
end

function aux_lspconfig.entry()
    aux_lspconfig.basic_quick_set()
    aux_lspconfig.diagnostic_quick_set()
    aux_lspconfig.lspconfig_ui_quick_set()
end

function aux_lspconfig.register_key(client, bufnr)
    local md = { silent = true, buffer = bufnr }
    map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, md, "Show code action")
    -- if client.resolved_capabilities.rename then
        map("n", "<leader>cn", function() vim.lsp.buf.rename() end, md, "Variable renaming")
    -- end
    -- if client.resolved_capabilities.document_formatting then
        map("n", "<leader>cf", function() vim.lsp.buf.format() end, md, "Format buffer")
    -- end
    -- if client.resolved_capabilities.hover then
        map("n", "gh", function() vim.lsp.buf.hover() end, md, "Show help information[LSP]")
        map("n", "K", function() vim.lsp.buf.hover() end, md, "Show help information[LSP]")
    -- end
    -- if client.resolved_capabilities.find_references then
        map("n", "gr", function() require("telescope.builtin").lsp_references() end, md, "Go to references[LSP]")
    -- end
    -- if client.resolved_capabilities.implementation then
        map("n", "gI", function() require("telescope.builtin").lsp_implementations() end, md, "Go to implementations[LSP]")
    -- end
    -- if client.resolved_capabilities.goto_definition then
        map("n", "gd", function() require("telescope.builtin").lsp_definitions() end, md, "Go to definitions[LSP]")
    -- end
    -- if client.resolved_capabilities.type_definition then
        map("n", "gD", function() require("telescope.builtin").lsp_type_definitions() end, md, "Go to type definitions[LSP]")
    -- end
    -- if client.resolved_capabilities.declaration then
        map("n", "gD", function() require("telescope.builtin").lsp_declaration() end, md, "Go to type definitions[LSP]")
    -- end
    map("n", "gO", function() require("telescope.builtin").diagnostics() end, md, "Show Workspace Diagnostics[LSP]")
    map("n", "go", aux_lspconfig.diagnostic_open_float, md, "Show Current Diagnostics[LSP]")
    map("n", "[d", aux_lspconfig.goto_prev_diagnostic, md, "Jump to prev diagnostic[LSP]")
    map("n", "]d", aux_lspconfig.goto_next_diagnostic, md, "Jump to next diagnostic[LSP]")

    map("i", "<c-b>", aux_lspconfig.scroll_to_up, md, "Scroll up floating window[LSP]")
    map("i", "<c-f>", aux_lspconfig.scroll_to_down, md, "Scroll down floating window[LSP]")
    map("i", "<c-]>", aux_lspconfig.focus_float_window(), md, "Focus floating window[LSP]")

    -- if client.resolved_capabilities.signature_help then
        map("i", "<c-j>", aux_lspconfig.sigature_help, md, "Toggle signature help[LSP]")
    -- end

    map("n", "<leader>li", "<cmd>LspInfo<CR>", md, "Info")
    map("n", "<leader>ls", "<cmd>LspStart<CR>", md, "Start")
    map("n", "<leader>lS", "<cmd>LspStop<CR>", md, "Stop")
    map("n", "<leader>lr", "<cmd>LspRestart<CR>", md, "Restart")
    map("n", "<leader>ll", "<cmd>LspLog<CR>", md, "Log")
end

function aux_lspconfig.metals_config()
    local metals = require("metals")
    local aerial = require("aerial")
    local nvim_navic = require("nvim-navic")

    local metals_config = metals.bare_config()
    metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }
    metals_config.on_attach = function(client, bufnr)
        aux_lspconfig.register_key(client, bufnr)
        -- aerial.on_attach(client, bufnr)
        nvim_navic.attach(client, bufnr)
    end
    return metals_config
end

return aux_lspconfig
