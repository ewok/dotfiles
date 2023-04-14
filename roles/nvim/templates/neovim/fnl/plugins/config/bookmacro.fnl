(local {: map!} (require :lib))

{:config #(let [bookmacro (require :bookmacro)]
            (bookmacro.setup)
            (map! :n :<leader>ml vim.cmd.MacroSelect {:silent true}
                  "Load into registry")
            (map! :n :<leader>me vim.cmd.MacroExec {:silent true}
                  "Execute a macro")
            (map! :n :<leader>ms vim.cmd.MacroAdd {:silent true}
                  "Save macro from registry")
            (map! :n :<leader>mmm vim.cmd.MacroEdit {:silent true}
                  "Modify macro")
            (map! :n :<leader>mmd vim.cmd.MacroDescEdit {:silent true}
                  "Modify description")
            (map! :n :<leader>mmr vim.cmd.MacroRegEdit {:silent true}
                  "Modify macro in register")
            (map! :n :<leader>mx vim.cmd.MacroDel {:silent true}
                  "Delete a macro")
            (map! :n :<leader>mEa vim.cmd.MacroExport {:silent true}
                  "Export all macros")
            (map! :n :<leader>mEm vim.cmd.MacroExportTo {:silent true}
                  "Export a macro(1)")
            (map! :n :<leader>mIa vim.cmd.MacroImport {:silent true}
                  "Import all macros")
            (map! :n :<leader>mIm vim.cmd.MacroImportFrom {:silent true}
                  "Import a macro(1)"))}
