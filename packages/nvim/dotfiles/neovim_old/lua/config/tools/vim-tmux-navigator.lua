local M = {}

function M.before() end

function M.load()
    vim.g.tmux_navigator_save_on_switch = 2
    vim.g.tmux_navigator_disable_when_zoomed = 1
end

function M.after() end

return M
