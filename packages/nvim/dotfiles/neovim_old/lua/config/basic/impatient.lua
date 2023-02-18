-- https://github.com/lewis6991/impatient.nvim

local M = {
    requires = {
        "impatient",
    },
}

function M.before() end

function M.load()
    M.impatient.enable_profile()
end

function M.after() end

return M

