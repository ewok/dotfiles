-- https://github.com/mfussenegger/nvim-dap

local api = require("utils.api")
local map = api.map.map

local M = {
    requires = {
        "dap",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    local configurations_dir_path = "config.dap.dap_configurations"

    local require_file_tbl = api.path.get_importable_subfiles(configurations_dir_path)

    for _, require_file in ipairs(require_file_tbl) do
        local dap_config = require(require_file)
        M.dap.adapters = vim.tbl_deep_extend("force", M.dap.adapters, dap_config.adapters)
        M.dap.configurations = vim.tbl_deep_extend("force", M.dap.configurations, dap_config.configurations)
    end
end

function M.after() end

function M.register_key()
    local md = { silent = true, buffer = true }
    map("n", "<leader>db", function() require "dap".toggle_breakpoint() end, md, 'Toggle Breakpoint')
    map("n", "<leader>dc", function() require "dap".continue() end, md, 'Run/Continue')
    map("n", "<leader>dC", function() require "dap".clear_breakpoints() end, md,
        'Clear breakpoints in the current buffer')
    map("n", "<leader>dn", function() require "dap".step_over() end, md, 'Step Over')
    map("n", "<leader>di", function() require "dap".step_into() end, md, 'Step Into')
    map("n", "<leader>do", function() require "dap".step_out() end, md, 'Step Out')
    map("n", "<leader>dS", function() require "dap".terminate() end, md, 'Stop')
    map("n", "<leader>dr", function() require "dap".repl.open() end, md, 'REPL')
    map("n", "<leader>dl", function() require "dap".run_last() end, md, 'Rerun debug')
end

return M
