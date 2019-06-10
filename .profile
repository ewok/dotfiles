# $HOME/.profile

#Set our umask
umask 022

# Set our default path
PATH="$HOME/go/bin:$HOME/bin:$HOME/.local/bin:$HOME/.config/bspwm/panel:/usr/local/sbin:/usr/local/bin:/usr/bin/core_perl:/usr/bin:$PATH"
export PATH

TZ='Europe/Moscow'; export TZ

# Preferred editor for local and remote sessions */

export BROWSER=/usr/bin/firefox
export BSPWM_SOCKET="/tmp/bspwm-socket"
export EDITOR='nvim'
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GUI_EDITOR=/usr/bin/nvim
export PANEL_FIFO="/tmp/panel-fifo"
export PANEL_HEIGHT=25
export QT_QPA_PLATFORMTHEME="qt5ct"
export TERMINAL=/usr/bin/xst
export VISUAL='nvim'
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
export XDG_CONFIG_HOME="$HOME/.config"

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

if [ -z "$SSH_AUTH_SOCK" ]
then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]
   then
        # Launch a new instance of the agent
        ssh-agent -s &> .ssh/ssh-agent
   fi
   eval `cat .ssh/ssh-agent`
fi
