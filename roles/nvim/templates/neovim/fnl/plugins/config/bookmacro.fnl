(local {: map!} (require :lib))

{:config #(let [bookmacro (require :bookmacro)]
            (bookmacro.setup)
            (map! :n :<leader>ml vim.cmd.MacroSelect {:silent true}
                  "Load a macro to a registry")
            (map! :n :<leader>me vim.cmd.MacroExec {:silent true}
                  "Execute a macro from BookMacro")
            (map! :n :<leader>ma vim.cmd.MacroAdd {:silent true}
                  "Add a macro to BookMacro")
            (map! :n :<leader>mmm vim.cmd.MacroEdit {:silent true}
                  "Modify a macro from BookMacro")
            (map! :n :<leader>mmd vim.cmd.MacroDescEdit {:silent true}
                  "Modify a description of a macro from BookMacro")
            (map! :n :<leader>mmr vim.cmd.MacroRegEdit {:silent true}
                  "Modify a macro from register")
            (map! :n :<leader>mx vim.cmd.MacroDel {:silent true}
                  "Delete a macro from BookMacro")
            (map! :n :<leader>mEa vim.cmd.MacroExport {:silent true}
                  "Export BookMacro to a JSON file")
            (map! :n :<leader>mEm vim.cmd.MacroExportTo {:silent true}
                  "Export a macro(1) to a JSON file")
            (map! :n :<leader>mIa vim.cmd.MacroImport {:silent true}
                  "Import BookMacro with a JSON file")
            (map! :n :<leader>mIm vim.cmd.MacroImportFrom {:silent true}
                  "Import a macro(1) from a JSON file")
            (map! :n :<leader>mX vim.cmd.MacroErase {:silent true}
                  "Erase all macros from The Book"))}
