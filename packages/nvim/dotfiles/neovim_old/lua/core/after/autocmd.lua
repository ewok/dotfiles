local options = require("core.options")

-- auto save buffer
if options.auto_save then
    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
        pattern = { "*" },
        command = "silent! wall",
        nested = true,
    })
end

-- switch input method
if options.auto_switch_input then
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = { "*" },
        callback = function()
            local input_status = tonumber(vim.fn.system("fcitx5-remote"))
            if input_status == 2 then
                vim.fn.system("fcitx5-remote -c")
            end
        end,
    })
end

-- auto restore cursor position
if options.auto_restore_cursor_position then
    vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
                vim.fn.setpos(".", vim.fn.getpos("'\""))
                -- how do I center the buffer in a sane way??
                -- vim.cmd('normal zz')
                vim.cmd("silent! foldopen")
            end
        end,
    })
end

-- remove auto-comments
if options.auto_remove_new_lines_comment then
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = "*",
        callback = function()
            vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
        end,
    })
end

-- auto toggle rnu
if options.auto_toggle_rnu then
    vim.wo.rnu = true
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = { "*" },
        callback = function()
            if vim.api.nvim_get_option('showcmd') then
                vim.wo.rnu = true
            end
        end
    })
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        pattern = { "*" },
        callback = function()
            if vim.api.nvim_get_option('showcmd') then
                vim.wo.rnu = false
            end
        end
    })
end

-- auto hide cursorline
if options.auto_hide_cursorline then

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = { "*" },
        command = "set cursorline"
    })
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        pattern = { "*" },
        command = "set nocursorline"
    })
end
