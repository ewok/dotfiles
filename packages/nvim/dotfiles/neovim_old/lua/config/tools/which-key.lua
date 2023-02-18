local M = {
    requires = {
        "which-key",
    },
}

function M.before() end

function M.load()
    M.which_key.setup({
        plugins = {
            spelling = {
                enabled = true,
                suggestions = 20,
            },
        },
        icons = {
            breadcrumb = " ",
            separator = " ",
            group = " ",
        },
    })
end
function M.after()
    -- global leader
    M.which_key.register({
        b = { name = "Buffers" },
        c = { name = "Code" },
        d = { name = "Debug" },
        f = { name = "Find" },
        fs = { name = "Settings" },
        g = { name = "Git" },
        gf = { name = "Git Fetch" },
        gl = { name = "Git Log" },
        gp = { name = "Git Push" },
        i = { name = "Insert" },
        l = { name = "Lsp" },
        -- o = { name = "Options" },
        -- os = { name = "Settings" },
        p = { name = "Packer | Profiling" },
        r = { name = "Replace", w = "Replace Word To ..." },
        s = { name = "Session" },
        y = { name = "Yank" },
        yf = { name = "File" },
        t = {
            name = "Terminal | Toggle",
        },
        w = { name = "Wiki" },
    }, { prefix = "<leader>", mode = "n" })

    -- comment
    M.which_key.register({
        c = {
            name = "Comment",
            c = "Toggle line comment",
            b = "Toggle block comment",
            a = "Insert line comment to line end",
            j = "Insert line comment to next line",
            k = "Insert line comment to previous line",
        },
    }, { prefix = "g", mode = "n" })
end

return M
