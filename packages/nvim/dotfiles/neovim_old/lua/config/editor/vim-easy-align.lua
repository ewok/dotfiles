local api = require("utils.api")
local map = api.map.map

local M = {}

function M.before() end
function M.load()
    map("n", "ga", "<Plug>(LiveEasyAlign)", {noremap = true}, 'Align Block')
    map("x", "ga", "<Plug>(LiveEasyAlign)", {noremap = true}, 'Align Block')
end
function M.after() end

return M
