{:Lua {:runtime {:version :LuaJIT}
       :diagnostics {:globals [:vim :conf]}
       :workspace {:library (vim.api.nvim_get_runtime_file "" true)}
       :telemetry {:enable false}}}
