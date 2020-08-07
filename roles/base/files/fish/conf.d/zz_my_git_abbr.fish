# my git initialization hook
# Was taken from plugin-git_init

set -q __git_plugin_initialized; or exit 0
# set -q __my_git_plugin_initialized; and exit 0

function __git_abbr -d "Create Git plugin abbreviation"
  set -l name $argv[1]
  set -l body $argv[2..-1]
  abbr -a $name $body
  #set __git_plugin_abbreviations $__git_plugin_abbreviations $name
end

# my git abbreviations
abbr -q glod; and abbr -e glod
__git_abbr glod "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
__git_abbr glods "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
__git_abbr gloga 'git log --oneline --decorate --graph --all'
abbr -q glog; and abbr -e glog
__git_abbr glog 'git log --oneline --decorate --graph'
__git_abbr glola "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
__git_abbr glol "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
__git_abbr glols "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"

# Cleanup declared functions
functions -e __git_abbr

# Mark git plugin as initialized
# set -U __my_git_plugin_initialized (date)
