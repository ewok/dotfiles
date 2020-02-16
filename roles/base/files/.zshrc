# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/bin:$PATH

ZSH_THEME="norm"
HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=(fzf colored-man-pages ssh-agent git)

# HISTORY_OPTION
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# My customs
ZSH_CUSTOM=~/.zsh/custom

source $ZSH/oh-my-zsh.sh

# Tuning appearance of the git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}(%{$fg[blue]%}git%{$fg[white]%}:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}) "
# User configuration
# PROMPT='%{$fg[yellow]%}λ %{$fg[cyan]%}$USER@%m %{$fg[green]%}%(5~|%-1~/…/%3~|%4~) $(pyenv_prompt_info)$(git_prompt_info)$(tf_prompt_info_patched)%{$reset_color%}'
PROMPT='$(pyenv_prompt_info)$(git_prompt_info)$(tf_prompt_info_patched)%{$fg[yellow]%}λ %{$fg[cyan]%}$USER@%m %{$fg[green]%}%(5~|%-1~/…/%3~|%4~) %{$reset_color%}'
RPROMPT="[%*]"

# SSH-AGENT
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Add ssh keys
zstyle :omz:plugins:ssh-agent identities id_ed25519

## Local specific settings
# You may want to override this options:
export JIRA_DEFAULT_ACTION=branch
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export OPEN_CMD=open

# LOCALE
export LANG=en_US.UTF-8
# export LC_CTYPE="ru_RU.UTF-8"
export LC_NUMERIC="ru_RU.UTF-8"
export LC_TIME="ru_RU.UTF-8"
export LC_COLLATE="ru_RU.UTF-8"
export LC_MONETARY="ru_RU.UTF-8"
# export LC_MESSAGES="ru_RU.UTF-8"
export LC_PAPER="ru_RU.UTF-8"
export LC_NAME="ru_RU.UTF-8"
export LC_ADDRESS="ru_RU.UTF-8"
export LC_TELEPHONE="ru_RU.UTF-8"
export LC_MEASUREMENT="ru_RU.UTF-8"
export LC_IDENTIFICATION="ru_RU.UTF-8"
export LC_ALL=

# FZF
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git,mnt -g "" -U'
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -f ~/.zshrc.local ];then
    source ~/.zshrc.local
fi
