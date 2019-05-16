# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="norm"
HIST_STAMPS="yyyy-mm-dd"

# My customs
ZSH_CUSTOM=~/.zsh/custom

# Plugins
plugins=(fzf colored-man-pages golang tmux vault ssh-agent autojump docker git)

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

source $ZSH/oh-my-zsh.sh

# User configuration
PROMPT='%{$fg[yellow]%}λ %{$fg[green]%}%~ %{$fg[yellow]%}→ $(git_prompt_info)%{$reset_color%}'
RPROMPT="[%*]"

# Set our default path
PATH="$HOME/go/bin:$HOME/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:$PATH"
export PATH

TZ='Europe/Moscow'; export TZ

# Preferred editor for local and remote sessions */
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

ANSIBLE_LIBRARY=$HOME/.ansible/plugins/core:$HOME/.ansible/plugins/extras

# SSH-AGENT
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Add ssh keys
zstyle :omz:plugins:ssh-agent identities id_ed25519

## FZF
# https://github.com/junegunn/fzf
export FZF_COMPLETION_TRIGGER='*'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Local specific settings
# You may want to override this options:
export JIRA_DEFAULT_ACTION=branch
export LANG=ru_RU.UTF-8
export LC_ALL=ru_RU.UTF-8
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export OPEN_CMD=open

if [ -f ~/.zshrc.local ];then
    source ~/.zshrc.local
fi

