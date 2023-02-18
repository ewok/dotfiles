-- https://github.com/akinsho/bufferline.nvim

local api = require("utils.api")
local public = require("utils.public")
local icons = public.get_icons("diagnostic", true)

local M = {
    requires = {
        "bufferline",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.bufferline.setup({
        options = {
            themable = true,
            -- ordinal
            numbers = "none",
            buffer_close_icon = "",
            modified_icon = "●",
            -- left_trunc_marker = "",
            -- right_trunc_marker = "",
            diagnostics = "nvim_lsp",
            separator_style = "slant",
            -- indicator = { icon = "▎", style = "icon" },
            show_buffer_close_icons = false,
            show_close_icon = false,
            show_tab_indicators = true,
            sort_by = "directory",
            persist_buffer_sort = true,
            always_show_bufferline = true,
            ---@diagnostic disable-next-line: unused-local
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local message
                if diagnostics_dict.error then
                    message = string.format("%s%s", icons.Error, diagnostics_dict.error)
                elseif diagnostics_dict.warning then
                    message = string.format("%s%s", icons.Warn, diagnostics_dict.warning)
                elseif diagnostics_dict.info then
                    message = string.format("%s%s", icons.Info, diagnostics_dict.info)
                elseif diagnostics_dict.hint then
                    message = string.format("%s%s", icons.Hint, diagnostics_dict.hint)
                else
                    message = ""
                end
                return message
            end,
            -- custom_areas = {
            --     right = function()
            --         return {
            --             { text = "  ", guifg = "#f28fad", guibg = "#1A1826" },
            --         }
            --     end,
            -- },
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "aerial",
                    text = "Outline Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "undotree",
                    text = "Undo Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "dbui",
                    text = "Database Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "spectre_panel",
                    text = "Project Blurry Search",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "toggleterm",
                    text = "Integrated Terminal",
                    highlight = "Directory",
                    text_align = "center",
                },
            },
        },
    })
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<C-W>d",
            rhs = "<cmd>BufferDelete<cr>",
            options = { silent = true },
            description = "Close current buffer",
        },
        {
            mode = { "n" },
            lhs = "<C-W><C-D>",
            rhs = "<cmd>BufferDelete<cr>",
            options = { silent = true },
            description = "Close current buffer",
        },
        {
            mode = { "n" },
            lhs = "<S-Tab>",
            rhs = "<cmd>BufferLineCyclePrev<cr>",
            options = { silent = true },
            description = "Go to left buffer",
        },
        {
            mode = { "n" },
            lhs = "<Tab>",
            rhs = "<cmd>BufferLineCycleNext<cr>",
            options = { silent = true },
            description = "Go to right buffer",
        },
        {
            mode = { "n" },
            lhs = "<leader>bn",
            rhs = "<cmd>enew<cr>",
            options = { silent = true },
            description = "Create new buffer",
        },
        {
            mode = { "n" },
            lhs = "<leader>bh",
            rhs = "<cmd>BufferLineCloseLeft<cr>",
            options = { silent = true },
            description = "Close all left buffers",
        },
        {
            mode = { "n" },
            lhs = "<leader>bl",
            rhs = "<cmd>BufferLineCloseRight<cr>",
            options = { silent = true },
            description = "Close all right buffers",
        },
        {
            mode = { "n" },
            lhs = "<leader>bo",
            rhs = function()
                vim.cmd("BufferLineCloseLeft")
                vim.cmd("BufferLineCloseRight")
            end,
            options = { silent = true },
            description = "Close all other buffers",
        },
        {
            mode = { "n" },
            lhs = "<leader>ba",
            rhs = function()
                vim.cmd("BufferLineCloseLeft")
                vim.cmd("BufferLineCloseRight")
                vim.cmd("BufferDelete")
            end,
            options = { silent = true },
            description = "Close all buffers",
        },
        {
            mode = { "n" },
            lhs = "<leader>bt",
            rhs = "<cmd>BufferLinePick<cr>",
            options = { silent = true },
            description = "Go to buffer *",
        },
        {
            mode = { "n" },
            lhs = "<leader>bs",
            rhs = "<cmd>BufferLineSortByDirectory<cr>",
            options = { silent = true },
            description = "Buffers sort (by directory)",
        },
        {
            mode = { "n" },
            lhs = "<leader>b1",
            rhs = "<cmd>BufferLineGoToBuffer 1<cr>",
            options = { silent = true },
            description = "Go to buffer 1",
        },
        {
            mode = { "n" },
            lhs = "<leader>b2",
            rhs = "<cmd>BufferLineGoToBuffer 2<cr>",
            options = { silent = true },
            description = "Go to buffer 2",
        },
        {
            mode = { "n" },
            lhs = "<leader>b3",
            rhs = "<cmd>BufferLineGoToBuffer 3<cr>",
            options = { silent = true },
            description = "Go to buffer 3",
        },
        {
            mode = { "n" },
            lhs = "<leader>b4",
            rhs = "<cmd>BufferLineGoToBuffer 4<cr>",
            options = { silent = true },
            description = "Go to buffer 4",
        },
        {
            mode = { "n" },
            lhs = "<leader>b5",
            rhs = "<cmd>BufferLineGoToBuffer 5<cr>",
            options = { silent = true },
            description = "Go to buffer 5",
        },
        {
            mode = { "n" },
            lhs = "<leader>b6",
            rhs = "<cmd>BufferLineGoToBuffer 6<cr>",
            options = { silent = true },
            description = "Go to buffer 6",
        },
        {
            mode = { "n" },
            lhs = "<leader>b7",
            rhs = "<cmd>BufferLineGoToBuffer 7<cr>",
            options = { silent = true },
            description = "Go to buffer 7",
        },
        {
            mode = { "n" },
            lhs = "<leader>b8",
            rhs = "<cmd>BufferLineGoToBuffer 8<cr>",
            options = { silent = true },
            description = "Go to buffer 8",
        },
        {
            mode = { "n" },
            lhs = "<leader>b9",
            rhs = "<cmd>BufferLineGoToBuffer 9<cr>",
            options = { silent = true },
            description = "Go to buffer 9",
        },
    })
end

return M
