"""Installation script."""
import os
import requests
from invoke import task

from helpers import makesl, npm_i, yay, pacman_remove, install_gitrepo, install_virtualenv


@task
def ensure_yay_exists(c):
    """Ensure yay command exists."""
    c.run("sudo pacman -S yay --needed")


@task
def install_base(c):
    """Install base software."""
    print("################################################################################")
    print("BASE STARTED")

    packages_to_install = [
        "gcc", "xst", "tmux", "python2",
        "python3", "python-virtualenv", "unzip", "p7zip",
        "zsh-autosuggestions", "restic", "trash-cli",
        "siji-git", "ttf-unifont", "nerd-fonts-noto-sans-mono",
        "nvme-cli", "xclip", "xsel", "par", "sshfs", "curlftpfs",
        "archivemount", "autorandr", "timeshift",
        "rbenv", "ruby-build", "moc", "jq", "pyenv",
        "pyenv-virtualenv", "npm", "ttf-liberation",
        "blacklist_pcspkr", "xorg-xbacklight",
        "gotty", "podman", "manjaro-pulse", "pa-applet",
        "pavucontrol", "blueman", "vifm",
        "zathura", "zathura-cb", "zathura-djvu", "zathura-pdf-mupdf"

    ]

    paths_to_link = [
        ("config/.tmux.conf", "~/.tmux.conf"),
        ("config/.zshrc", "~/.zshrc"),
        ("config/.zsh", "~/.zsh"),
        ("config/.zprofile", "~/.zprofile"),
        ("config/.i3", "~/.i3"),
        ("config/.i3status.conf", "~/.i3status.conf"),
        ("config/.xprofile", "~/.xprofile"),
        ("config/.profile", "~/.profile"),
        ("config/.Xresources", "~/.Xresources"),
        ("config/.skhdrc", "~/.skhdrc"),
        ("config/.yabairc", "~/.yabairc"),
        ("bin", "~/bin"),
    ]

    packages_to_remove = [
        'vim', 'palemoon-bin'
    ]

    gitrepos_to_install = [
        ("https://github.com/junegunn/fzf.git", "~/.fzf"),
        ("https://github.com/tmux-plugins/tmux-resurrect", "~/.tmux/resurrect"),
        ("git://github.com/robbyrussell/oh-my-zsh.git", "~/.oh-my-zsh"),
    ]

    pacman_remove(c, packages_to_remove)

    yay(c, packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.expanduser(pair[1]))

    for pair in gitrepos_to_install:
        install_gitrepo(c, pair[0], os.path.expanduser(pair[1]))

    # FZF Installation
    c.run("$HOME/.fzf/install --no-bash --no-fish --no-update-rc --key-bindings --completion")

    print("BASE FINISHED")

@task
def install_gui_tools(c):
    """Install packages."""
    print("################################################################################")
    print("GUI STARTED")

    packages_to_install = [
        "flameshot", "todoist-linux-bin",
        "slack-desktop", "redshift-gtk-git", "zeal",
        "cawbird", "masterpdfeditor-free", "cryptomator",
        "firefox", "enpass-bin"
    ]

    paths_to_link = [
        ("config/Zeal", "~/.config/Zeal"),
    ]

    yay(c, packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.expanduser(pair[1]))

    print("GUI FINISHED")

@task
def install_mail(c):
    """Install mail software."""
    print("################################################################################")
    print("MAIL STARTED")

    packages_to_install = [
        "mbsync", "msmtp", "neomutt", "notmuch", "notmuch-mutt",
        "davmail", "goobook", "lbdb", "vcal", "pass",
        "pandoc"
    ]

    paths_to_link = [
        ("config/.mbsyncrc", "~/.mbsyncrc"),
        ("config/.msmtp", "~/.msmtp"),
        ("config/muttrc", "~/.muttrc"),
        ("config/mutt", "~/.mutt")
    ]

    yay(c, packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.expanduser(pair[1]))

    print("MAIL FINISHED")

@task
def install_editor(c):
    """Install editor and all editor tools."""
    print("################################################################################")
    print("EDITOR STARTED")

    packages_to_install = [
        "neovim", "ctags", "global", "the_silver_searcher",
        "xkb-switch", "cht.sh", "shellcheck", "yamllint",
        "vale-bin", "hadolint-bin"
    ]

    paths_to_link = [
        ("config/nvim", "~/.config/nvim"),
        ("config/.ideavimrc", "~/.ideavimrc"),
        ("config/vifm", "~/.vifm"),
        ("config/vifm", "~/.config/vifm"),
        ("config/.ctags", "~/.ctags"),
    ]

    npm_packages_to_install = [
        "markdownlint-cli", "bash-language-server", "livedown"
    ]

    virtualenvs = [
        ("~/share/venv/neovim2", "python2", ['neovim', 'pynvim']),
        ("~/share/venv/neovim3", "python3", ['neovim', 'pynvim']),
    ]

    yay(c, packages_to_install)

    c.run("curl -JL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > ~/.local/bin/nvim")
    c.run("chmod +x ~/.local/bin/nvim")
    c.run("nvim +PlugInstall +qall")

    npm_i(c, npm_packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.expanduser(pair[1]))

    for element in virtualenvs:
        install_virtualenv(c, os.path.expanduser(element[0]), element[1], element[2])

    # Provide some configs

    response = requests.get("http://www.gitignore.io/api/go,python,linux,macos")

    if response.ok:
        with open(os.path.expanduser("~/.gitexcludes"), "w") as gitignore_config:
            print(response.text, file=gitignore_config)

    c.run("git config --global alias.ignore "
          "'!gi() { curl -sL https://www.gitignore.io/api/$@ ;}; gi'")

    c.run("git config --global core.excludesfile '~/.gitexcludes'")
    c.run("git config --global credential.helper '/usr/share/git/credential/gnome-keyring/git-credential-gnome-keyring'")
    c.run('git config --global --replace-all core.pager "less -F -X"')

    with open(os.path.expanduser("~/.vale.ini"), "w") as vale_config:

        config = """# Core settings
StylesPath = ci/vale/styles

# The minimum alert level to display (suggestion, warning, or error).
#
# CI builds will only fail on error-level alerts.
MinAlertLevel = warning

# The "formats" section allows you to associate an "unknown" format
# with one of Vale's supported formats.
[formats]
mdx = md

# Global settings (applied to every syntax)
[*]
# List of styles to load
BasedOnStyles = write-good, Joblint
# Style.Rule = {YES, NO} to enable or disable a specific rule
vale.Editorializing = YES
# You can also change the level associated with a rule
vale.Hedging = error

# Syntax-specific settings
# These overwrite any conflicting global settings
[*.{md,txt}]
vale.Editorializing = NO"""
        print(config, file=vale_config)

    print("EDITOR FINISHED")


@task
def install_albert(c):
    """Install albert."""
    print("################################################################################")
    print("ALBERT STARTED")

    yay(c, ["albert", "muparser"])

    install_gitrepo(c, "https://github.com/IanS5/albert-todoist.git", os.path.expanduser("~/.albert_todoist"))

    install_dir="~/.local/share/albert/org.albert.extension.python/modules"
    paths_to_link = [
        ("config/albert/modules/locate.py", "{0}/locate.py".format(install_dir)),
        ("~/.albert_todoist/__init__.py", "{0}/Todoist/__init__.py".format(install_dir)),
        ("~/.albert_todoist/todoist.svg", "{0}/Todoist/todoist.svg".format(install_dir)),
        ("config/albert/albert.conf", "~/.config/albert/albert.conf"),
    ]

    for pair in paths_to_link:
        makesl(os.path.expanduser(pair[0]), os.path.expanduser(pair[1]))

# Not implemented yet
#  if [ -d $HOME/.puppetlsp ]; then rm -rf $HOME/.puppetlsp;fi
#  git clone --depth 1 https://github.com/lingua-pupuli/puppet-editor-services.git $HOME/.puppetlsp
#  cd $HOME/.puppetlsp
#  eval "$(rbenv init -)"
#  rbenv install 2.5.7
#  rbenv shell 2.5.7
#  gem install puppet puppet-lint r10k
#  bundle install

    print("ALBERT FINISHED")

@task
def install_printer(c):
    """Install printer stuff."""
    print("################################################################################")
    print("PRINTER STARTED")

    yay(c, ["cups", "xsane", "system-config-printer"])

    install_gitrepo(c, "https://github.com/ondrej-zary/carps-cups.git", os.path.expanduser("~/tmp/carps-cups"))

    c.run(
        "cd ~/tmp/carps-cups;"
        "make && sudo make install;"
        "rm -rf ~/tmp/carps-cups;"
        "sudo systemctl enable cups-browsed.service;"
        "sudo systemctl start cups-browsed.service"
    )

    print("PRINTER FINISHED")

@task
def install_appimage(c):
    """Install appimage stuff."""
    print("################################################################################")
    print("APPIMAGE STARTED")

    c.run(
        "curl -J -L https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage > ~/.local/bin/appimagetool;"
        "chmod +x ~/.local/bin/appimagetool;"
    )

    print("APPIMAGE FINISHED")

@task
def install_add_td(c):
    """Install todoist add."""
    print("################################################################################")
    print("TODOIST STARTED")

    c.run(
        "cd pkg/add_td;"
        "makepkg -sicf"
    )

    print("TODOIST FINISHED")

@task
def install_joplin(c):
    """Install joplin"""
    packages_to_install = [
        "joplin"
    ]

    paths_to_link = [
        ("config/joplin/keymap.json", "~/.config/joplin/keymap.json"),
    ]

    yay(c, packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.expanduser(pair[1]))


@task(ensure_yay_exists, install_base, install_gui_tools, install_mail, install_editor, install_albert)
def install(c):
    """Install all."""
    print("ALL IS DONE")
