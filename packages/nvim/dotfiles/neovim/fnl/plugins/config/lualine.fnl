{:opts {:options {:theme (or conf.options.theme :auto)
                    :icons_enabled true
                    :component_separators {:left conf.separator.alt_left :right conf.separator.alt_right}
                    :section_separators {:left conf.separator.left :right conf.separator.right}
                    :disabled_filetypes []
                    :globalstatus true
                    :refresh {:statusline 100 :tabline 100 :winbar 100}}}}
