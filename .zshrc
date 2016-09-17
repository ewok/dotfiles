# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

SHARE_HISTORY="false"
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

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_backup id_rsa_old id_rsa_insecure

plugins=(ssh-agent emoji colored-man-pages zsh-autosuggestions)
JIRA_URL='https://hq-online.megafon.ru/jira'
source $ZSH/oh-my-zsh.sh

# User configuration
PROMPT='%{$fg[yellow]%}λ %{$fg[green]%}%c %{$fg[yellow]%}→ $(git_prompt_info)%{$reset_color%}'

# GO
export GOPATH=$HOME/documents/projects/go
export GOPATH
export GOBIN=/usr/local/opt/go/libexec/bin
export GO15VENDOREXPERIMENT=1 

#export HASKELLPATH=$HOME/Library/Haskell
#export HASKELLPATH

# Set our default path
# PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
PATH="$HOME/bin:$GOPATH/bin:$GOBIN:$HOME/.local/bin:/usr/local/sbin:$PATH"
export PATH


TZ='Europe/Moscow'; export TZ

# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions */
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi
alias vim='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias exit='sync; sync; sync; clear; exit'

alias tailf='tail -f'

# alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
#alias ytdown='source start-docker.sh && docker run --rm -v ${PWD}:/data vimagick/youtube-dl'
# alias ytdown='source start-docker.sh && docker run -ti -w /tmp --rm -v ${PWD}/:/tmp jbergknoff/youtube-dl'

compdef assh=ssh
compdef mosh=ssh

#alias vim='emacs -nw'
#alias gvim='emacs'

bindkey -s '^[x' '^Uexit^M'
bindkey -s '^[x' '^Uexit^M'

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

#
# export PATH=$(stack --verbosity 0 path --bin-path)
# Caching some variables
# vars="$HOME/.local/vars.src"
# function updatevars(){
#     echo "updating stack path"
#     echo "export PATH=$(stack --verbosity 0 path --bin-path)" > $vars
# }
# if [[ ! -e "$vars" ]]; then
#     echo "vars not exists"
#     updatevars
# elif test `find "$vars" -mmin +1000`; then
#     updatevars
# elif [[ -z $(cat "$vars") ]]; then
#     echo "vars empy"
#     updatevars;
# fi
# source $vars

# added by travis gem
[ -f /Users/arturtaranchiev/.travis/travis.sh ] && source /Users/arturtaranchiev/.travis/travis.sh

# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# # SSH completion
# h=()
# if [[ -r ~/.ssh/config ]]; then
#   h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
# fi
# if [[ -r ~/.ssh/known_hosts ]]; then
#   h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
# fi
# if [[ $#h -gt 0 ]]; then
#   zstyle ':completion:*:ssh:*' hosts $h
#   zstyle ':completion:*:slogin:*' hosts $h
# fi

