local util = require("lspconfig.util")

return {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_dir = util.root_pattern(".git", ".root"),
}
