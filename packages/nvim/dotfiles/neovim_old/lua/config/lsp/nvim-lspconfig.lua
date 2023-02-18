-- https://github.com/neovim/nvim-lspconfig

-- local map = require("utils.api").map.map
local aux_lspconfig = require("utils.aux.lspconfig")

local M = {
    requires = {
        "aerial",
        "lspconfig",
        "nvim-navic",
        "mason-lspconfig",
    },
}

function M.before() end

function M.load()
    aux_lspconfig.entry()

    local configurations_dir_path = "config/lsp/server_configurations/"

    for _, server_name in ipairs(M.mason_lspconfig.get_installed_servers()) do
        local require_path = string.format("%s%s", configurations_dir_path, server_name)

        local ok, settings = pcall(require, require_path)

        if not ok then
            settings = {}
        end

        settings.capabilities = aux_lspconfig.get_capabilities()
        settings.handlers = aux_lspconfig.get_headlers(settings)

        settings.on_attach = function(client, bufnr)
            aux_lspconfig.register_key(client, bufnr)
            -- M.aerial.on_attach(client, bufnr)
            M.nvim_navic.attach(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
        end

        M.lspconfig[server_name].setup(settings)
    end
end

function M.after() end

-- function M.register_key(client, bufnr)
--     local md = { silent = true, buffer = bufnr }
--     map("n","<leader>ca", function() vim.lsp.buf.code_action() end, md, "Show code action")
--     if client.resolved_capabilities.rename then
--         map("n","<leader>cn", function() vim.lsp.buf.rename() end, md, "Variable renaming")
--     end
--     if client.resolved_capabilities.document_formatting then
--         map("n","<leader>cf", function() vim.lsp.buf.formatting() end, md, "Format buffer")
--     end
--     if client.resolved_capabilities.hover then
--         map("n","gh", function() vim.lsp.buf.hover() end, md, "Show help information")
--         map("n","K", function() vim.lsp.buf.hover() end, md, "Show help information")
--     end
--     if client.resolved_capabilities.find_references then
--         map("n","gr", function() require("telescope.builtin").lsp_references() end, md, "Go to references")
--     end
--     if client.resolved_capabilities.implementation then
--         map("n","gI", function() require("telescope.builtin").lsp_implementations() end, md, "Go to implementations")
--     end
--     if client.resolved_capabilities.goto_definition then
--         map("n","gd", function() require("telescope.builtin").lsp_definitions() end, md, "Go to definitions")
--     end
--     if client.resolved_capabilities.type_definition then
--         map("n","gD", function() require("telescope.builtin").lsp_type_definitions() end, md, "Go to type definitions")
--     end
--     if client.resolved_capabilities.declaration then
--         map("n","gD", function() require("telescope.builtin").lsp_declaration() end, md, "Go to type definitions")
--     end
--     map("n","gO", function() require("telescope.builtin").diagnostics() end, md, "Show Workspace Diagnostics")
--     map("n","go", aux_lspconfig.diagnostic_open_float, md, "Show Current Diagnostics")
--     map("n","[d", aux_lspconfig.goto_prev_diagnostic, md, "Jump to prev diagnostic")
--     map("n","]d", aux_lspconfig.goto_next_diagnostic, md, "Jump to next diagnostic")
--
--     map("i","<c-b>", aux_lspconfig.scroll_to_up, md, "Scroll up floating window")
--     map("i","<c-f>", aux_lspconfig.scroll_to_down, md, "Scroll down floating window")
--     map("i","<c-]>", aux_lspconfig.focus_float_window(), md, "Focus floating window")
--
--     if client.resolved_capabilities.signature_help then
--         map("i","<c-j>", aux_lspconfig.sigature_help, md, "Toggle signature help")
--     end
-- end

return M
