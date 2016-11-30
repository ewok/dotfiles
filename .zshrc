# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#

# HISTORY_OPTION
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

plugins=(ssh-agent emoji colored-man-pages zsh-autosuggestions golang tmux vault)

source $ZSH/oh-my-zsh.sh

# User configuration
PROMPT='%{$fg[yellow]%}λ %{$fg[green]%}%c %{$fg[yellow]%}→ $(git_prompt_info)%{$reset_color%}'

# GO
export GOPATH=$HOME/Documents/projects/go
# export GOPATH
export GOBIN=$GOPATH/bin
# export GO15VENDOREXPERIMENT=1

#export HASKELLPATH=$HOME/Library/Haskell
#export HASKELLPATH

# Set our default path
# PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
PATH="$HOME/bin:$GOBIN:$HOME/.local/bin:/usr/local/sbin:$PATH"
export PATH


TZ='Europe/Moscow'; export TZ

# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions */
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi



bindkey -s '^[x' '^Uexit^M'
bindkey -s '^[x' '^Uexit^M'
bindkey -s '^D'  '^Uexit^M'

ANSIBLE_LIBRARY=$HOME/.ansible/plugins/core:$HOME/.ansible/plugins/extras
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }
 function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
 }

setjdk "1.7.0_80"
# setjdk "1.8.0_51"

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# SSH completion
compdef assh=ssh
compdef mosh=ssh
compdef telnet=ssh

h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# SSH-AGENT
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_backup id_rsa_old id_rsa_insecure id_rsa_ml


export FZF_COMPLETION_TRIGGER='*'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

for item in ~/.zsh/custom/*.zsh; do
    source $item
done

# Aliases block
alias tailf='tail -f'
alias exit='sync; sync; sync; clear; exit'
alias vi='/usr/local/bin/nvim'
alias vim='/usr/local/bin/nvim'

# MacOs aliases
alias resetsound="ps aux | grep 'coreaudio[d]' | awk '{print \$2}' | xargs sudo kill"
alias resetdns='sudo killall -HUP mDNSResponder && sudo pkill dnsmasq && echo DNS cleared'
