if [ -z "$HOSTNAME" ] && command -v hostnamectl >/dev/null 2>&1; then
  export HOSTNAME=$(hostnamectl --transient 2>/dev/null)
fi
if [ -z "$HOSTNAME" ] && command -v hostname >/dev/null 2>&1; then
  export HOSTNAME=$(hostname 2>/dev/null)
fi
if [ -z "$HOSTNAME" ]; then
  export HOSTNAME=$(uname -n)
fi

{% if ansible_distribution == 'MacOSX' %}
export PATH="/opt/homebrew/sbin:$PATH"
{% else %}
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_MEASUREMENT=ru_RU.UTF-8
export LC_MONETARY=ru_RU.UTF-8
export LC_NUMERIC=ru_RU.UTF-8
export LC_PAPER=ru_RU.UTF-8
export LC_TIME=ru_RU.UTF-8
export GTK_THEME=Adapta-Nokto
{% endif %}

export PATH=~/.local/bin:~/bin:~/.bin:$PATH

export FZF_LEGACY_KEYBINDINGS=0
export OPEN_CMD=open

{% if ansible_distribution == 'Void' %}
export XBPS_DISTDIR="{{ conf.void_distdir }}"
{% endif %}
