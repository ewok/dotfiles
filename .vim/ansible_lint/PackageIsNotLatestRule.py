# Copyright (c) 2016 Will Thames <will@thames.id.au>
from ansiblelint import AnsibleLintRule


class PackageIsNotLatestRule(AnsibleLintRule):
    id = 'R203'
    shortdesc = 'Package installs should not use latest'
    description = 'Package installs should use state=present ' + \
                  'with or without a version'
    tags = ['repeatability']

    _package_managers = ['yum', 'apt', 'dnf', 'homebrew', 'pacman',
                         'openbsd_package', 'pkg5', 'portage', 'pkgutil',
                         'slackpkg', 'swdepot', 'zypper', 'bundler', 'pip',
                         'pear', 'npm', 'gem', 'easy_install', 'bower', 'package']

    def matchtask(self, file, task):
        return (task['action']['__ansible_module__'] in self._package_managers and
                task['action'].get('state') == 'latest')
