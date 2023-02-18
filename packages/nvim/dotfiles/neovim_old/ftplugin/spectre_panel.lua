local api = require("utils.api")
local map = api.map.map

map("n", "q", ':close<cr>', { silent = true, buffer = true }, 'Close')
