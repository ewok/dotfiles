# Variables
set -x LANG en_US.UTF-8
# set -x LC_CTYPE "ru_RU.UTF-8"
set -x LC_NUMERIC "ru_RU.UTF-8"
set -x LC_TIME "ru_RU.UTF-8"
set -x LC_COLLATE "ru_RU.UTF-8"
set -x LC_MONETARY "ru_RU.UTF-8"
# set -x LC_MESSAGES "ru_RU.UTF-8"
set -x LC_PAPER "ru_RU.UTF-8"
set -x LC_NAME "ru_RU.UTF-8"
set -x LC_ADDRESS "ru_RU.UTF-8"
set -x LC_TELEPHONE "ru_RU.UTF-8"
set -x LC_MEASUREMENT "ru_RU.UTF-8"
set -x LC_IDENTIFICATION "ru_RU.UTF-8"
set -x LC_ALL

# Plugins configuration
# Pure
set -g pure_symbol_prompt "λ"
set -g pure_color_success green
# FZF
set -U FZF_LEGACY_KEYBINDINGS 0
set -x FZF_FIND_FILE_COMMAND 'rg --hidden --no-ignore --files'
set -x FZF_CD_COMMAND 'rg --hidden --no-ignore --files'
set -x FZF_OPEN_COMMAND 'rg --hidden --no-ignore --files'

_aliases

status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

# Other local staff
set -x OPEN_CMD open

#
#set -x MAIN_DISPLAY
