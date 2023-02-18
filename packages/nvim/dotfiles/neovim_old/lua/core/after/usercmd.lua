vim.api.nvim_create_user_command("BufferDelete", function()
    ---@diagnostic disable-next-line: missing-parameter
    local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
    local modified = vim.api.nvim_buf_get_option(0, "modified")

    if file_exists == 0 and modified then
        local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
        if user_choice == "y" or string.len(user_choice) == 0 then
            vim.cmd("bd!")
        end
        return
    end

    local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
    if force then
        vim.cmd("bd!")
    else
        local bufnr = vim.api.nvim_get_current_buf()
        vim.cmd("bp")
        if vim.api.nvim_buf_is_loaded(bufnr) then
            vim.cmd(string.format("bd! %s", bufnr))
        end
    end
end, { desc = "Delete the current Buffer while maintaining the window layout" })
