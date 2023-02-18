-- https://github.com/nvim-telescope/telescope.nvim

local api = require("utils.api")
local map = api.map.map

local M = {
    requires = {
        "telescope",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    local actions = require('telescope.actions')
    M.telescope.setup({
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--hidden',
                '--ignore',
                '--iglob',
                '!.git',
                '--ignore-vcs',
                '--ignore-file',
                '~/.config/git/gitexcludes',
            },
            prompt_prefix = " ",
            selection_caret = " ",
            entry_prefix = " ",
            multi_icon = " ",
            color_devicons = true,
            file_ignore_patterns = { "node_modules" },
            -- theme
            layout_strategy = "bottom_pane",
            -- config
            set_env = { ['COLORTERM'] = 'truecolor' },
            layout_config = {
                bottom_pane = {
                    height = 0.95,
                    preview_cutoff = 100,
                    prompt_position = "bottom",
                },
            },
            mappings = {
                i = {
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,

                    ["<C-s>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

                    ["<C-Space>"] = actions.toggle_selection + actions.move_selection_next,

                    -- ["<CR>"] = actions.select_default + actions.center,
                    ["<esc>"] = actions.close,
                },
                n = {
                    ["<esc>"] = actions.close,
                },
            },
        },
        pickers = {
            buffers = {
                mappings = {
                    i = {
                        ["<c-d>"] = "delete_buffer",
                    },
                    n = {
                        ["dd"] = "delete_buffer",
                    },
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })
end

function M.after()
    M.telescope.load_extension("fzf")

    -- FIX: https://github.com/nvim-telescope/telescope.nvim/issues/699
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "*" },
        command = "normal zx",
    })
end

function M.register_key()
    map("n", "<leader>fo",
        function()
            local find_command = {
                'rg',
                '--ignore',
                '--hidden',
                '--files',
                '--iglob',
                '!.git',
                '--ignore-vcs',
                '--ignore-file',
                '~/.config/git/gitexcludes',
            }
            require('telescope.builtin').find_files({ find_command = find_command })
        end, { silent = true }, "Find files in the current workspace")
    map("n",
        "<leader>ff",
        function()
            require("telescope.builtin").live_grep()
        end, { silent = true }, "Find string in the current workspace")
    map("n", "<leader>fh",
        function()
            require("telescope.builtin").oldfiles()
        end, { silent = true }, "Find telescope history")
    map("n", "<leader>f.",
        function()
            require("telescope.builtin").resume()
        end, { silent = true }, "Find last lookup")
    map("n", "<leader>fm",
        function()
            require("telescope.builtin").marks()
        end, { silent = true }, "Find marks in the current workspace")
    map("n", "<leader>fb",
        function()
            require("telescope.builtin").buffers()
        end, { silent = true }, "Find all buffers")
    map("n", "<leader>f/",
        function()
            require("telescope.builtin").current_buffer_fuzzy_find()
        end, { silent = true }, "Find string current buffer")
    map("n", "<leader>f:",
        function()
            require("telescope.builtin").command_history()
        end, { silent = true }, "Find all command history")

    map('n', '<leader>fss', '<cmd>Telescope vim_options<CR>', { silent = true }, 'Settings')
    map("n", "<leader>fH",
        function()
            require("telescope.builtin").help_tags()
        end, { silent = true }, "Help tags")
    map('n', '<leader>fsa', '<cmd>Telescope autocommands<CR>', { silent = true }, 'Autocommands')
    map('n', '<leader>fsf', '<cmd>Telescope filetypes<CR>', { silent = true }, 'Filetypes')
    map("n", "<leader>fsh",
        function()
            require("telescope.builtin").highlights()
        end, { silent = true }, "Highlights")
    map('n', '<leader>fsk', '<cmd>Telescope keymaps<CR>', { silent = true }, 'Keymaps')
    map('n', '<leader>fsc', '<cmd>Telescope colorscheme<CR>', { silent = true }, 'Colorschemes')
end

return M
