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

set -x OPEN_CMD open

# Plugins configuration
# Done
set -U __done_notify_sound 1
set -U __done_notification_urgency_level critical

# Pure
set -g pure_symbol_prompt "λ"
set -g pure_color_primary green
set -g pure_color_success green

_aliases
