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

set -gx TERM screen-256color;

set -gx PATH $HOME/bin $HOME/.local/bin $PATH
set -gx TZ 'Europe/Moscow'
set -gx BROWSER /usr/bin/firefox
set -gx EDITOR 'nvim'
set -gx GUI_EDITOR /usr/bin/nvim
set -gx TERMINAL /usr/bin/termite
set -gx VISUAL 'nvim'
set -gx XDG_CONFIG_HOME "$HOME/.config"

set fish_greeting

if status is-interactive

  # Plugins configuration
  # Pure
  set -Ux pure_symbol_prompt "λ"
  set -Ux pure_color_success green
  # FZF
  set -Ux FZF_LEGACY_KEYBINDINGS 0
  set -Ux FZF_FIND_FILE_COMMAND 'rg --hidden --no-ignore --files'
  set -Ux FZF_CD_COMMAND 'rg --hidden --no-ignore --files'
  set -Ux FZF_OPEN_COMMAND 'rg --hidden --no-ignore --files'

  _aliases

  source (pyenv init -|psub)
  source (pyenv virtualenv-init -|psub)

  # Other local staff
  set -Ux OPEN_CMD open

  #
  #set -x MAIN_DISPLAY
  #
  # Abbr

  abbr -a k kubectl
  abbr -a kx kubectx
  abbr -a ke kubens
  abbr -a tf terraform
  abbr -a tg terragrunt
  abbr -a h helm
  abbr -a mproc "smem -t -k -c pss -P"
  abbr -a egrep "egrep --color=always"
  abbr -a j jrnl

  bind \cw backward-kill-word

end

# SSH-AGENT
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end

starship init fish | source

