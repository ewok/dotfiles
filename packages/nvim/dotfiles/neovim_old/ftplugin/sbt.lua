local aux_lspconfig = require("utils.aux.lspconfig")
local metals = require("metals")

metals.initialize_or_attach(aux_lspconfig.metals_config())

