-- https://github.com/kyazdani42/nvim-tree.lua

local api = require("utils.api")
local public = require("utils.public")
local icons = public.get_icons("diagnostic", true)

local M = {
    requires = {
        "nvim-tree",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.nvim_tree.setup({
            open_on_setup       = false,
            open_on_tab         = false,

        disable_netrw = false,
        hijack_netrw = false,
        hijack_cursor = true,
        update_cwd = true,
        ignore_ft_on_setup = { "dashboard" },
        reload_on_bufenter = true,
        update_focused_file = {
            enable = false,
            update_cwd = false,
        },
            system_open = {
              cmd  = nil,
              args = {}
            },
        view = {
            side = "left",
            width = 40,
            hide_root_folder = false,
            signcolumn = "yes",
            mappings = {
                custom_only = true,
                list = {
                  { key = { "<CR>" },   action = "edit" },
                  { key = { "o" },      action = "edit" },
                  { key = { "l" },      action = "edit" },
                  { key = { "<C-]>" },  action = "cd" },
                  { key = { "C" },      action = "cd" },
                  { key = { "v" },      action = "vsplit" },
                  { key = { "s" },      action = "split" },
                  { key = { "t" },      action = "tabnew" },
                  { key = { "h" },      action = "close_node" },
                  { key = { "<Tab>" },  action = "preview" },
                  { key = { "I" },      action = "toggle_ignored" },
                  { key = { "H" },      action = "toggle_dotfiles" },
                  { key = { "r" },      action = "refresh" },
                  { key = { "R" },      action = "refresh" },
                  { key = { "a" },      action = "create" },
                  { key = { "d" },      action = "remove" },
                  { key = { "m" },      action = "rename" },
                  { key = { "M" },      action = "full_rename" },
                  { key = { "x" },      action = "cut" },
                  { key = { "c" },      action = "copy" },
                  { key = { "p" },      action = "paste" },
                  { key = { "[g" },     action = "prev_git_item" },
                  { key = { "]g" },     action = "next_git_item" },
                  { key = { "u" },      action = "dir_up" },
                  { key = { "q" },      action = "close" },
                }
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = icons.Hint,
                info = icons.Info,
                warning = icons.Warn,
                error = icons.Error,
            },
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = true,
                restrict_above_cwd = false,
            },
            open_file = {
                resize_window = true,
                quit_on_open = true,
                window_picker = {
                  enable = false
                }
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        filters = {
            dotfiles = false,
            custom = { "node_modules", "\\.cache", "__pycache__" },
            exclude = {},
        },
        renderer = {
            add_trailing = true,
              group_empty = true,
            highlight_git = true,
            highlight_opened_files = "none",
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "凜",
                        untracked = "",
                        deleted = "",
                        ignored = "",
                    },
                    folder = {
                        arrow_open = "",
                        arrow_closed = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                },
            },
        },
    })
end

function M.after()
end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>1",
            rhs = function()
                public.toggle_sidebar("NvimTree")
                vim.cmd("NvimTreeToggle")
            end,
            options = { silent = true },
            description = "Open File Explorer",
        },
        {
            mode = { "n" },
            lhs = "<leader>fp",
            rhs = function()
                public.toggle_sidebar("NvimTree")
                vim.cmd("NvimTreeFindFile")
            end,
            options = { silent = true },
            description = "Find the current file and open it in file explorer",
        },
    })
end

return M
