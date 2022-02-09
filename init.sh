#!/bin/env bash

set -e

if [[ $1 -eq 1 ]]
then
    curl -O https://tim.siosm.fr/downloads/siosm_gpg.pub
    sudo ostree remote add kinoite https://siosm.fr/kinoite/ --gpg-import siosm_gpg.pub || true

    sudo rpm-ostree rebase kinoite:fedora/34/x86_64/base || true

    sudo rpm-ostree reset

    sudo rpm-ostree install ansible

    sudo systemctl reboot
fi

if [[ $1 -eq 2 ]]
then

    ansible-galaxy collection install community.general

    bash update_toolboxes
    bash restart_toolboxes all

    echo Logout please
fi

if [[ $1 -eq 3 ]]
then


    bash rebuild.sh -K

    sudo usermod -s /bin/fish $USER

fi
