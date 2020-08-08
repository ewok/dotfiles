# $HOME/.profile

#Set our umask
umask 022

# Set our default path
PATH="$HOME/go/bin:$HOME/bin:$HOME/.local/bin:$PATH"
export PATH

TZ='Europe/Moscow'; export TZ

# Preferred editor for local and remote sessions */

export BROWSER=/usr/bin/firefox
export EDITOR='nvim'
export GUI_EDITOR=/usr/bin/nvim
export TERMINAL=/usr/bin/termite
export VISUAL='nvim'
export XDG_CONFIG_HOME="$HOME/.config"

export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Source global bash config
if test "$PS1" && test "$BASH" && test -r /etc/bash.bashrc; then
	. /etc/bash.bashrc
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH

# if [ -z "$SSH_AUTH_SOCK" ]
# then
#    # Check for a currently running instance of the agent
#    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
#    if [ "$RUNNING_AGENT" = "0" ]
#    then
#         # Launch a new instance of the agent
#         ssh-agent -s &> ~/.ssh/ssh-agent
#    fi
#    eval `cat ~/.ssh/ssh-agent`
# fi
