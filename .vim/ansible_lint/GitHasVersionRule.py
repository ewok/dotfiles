# Copyright (c) 2013-2014 Will Thames <will@thames.id.au>
from ansiblelint import AnsibleLintRule


class GitHasVersionRule(AnsibleLintRule):
    id = 'R202'
    shortdesc = 'Git checkouts must contain explicit version'
    description = 'All version control checkouts must point to ' + \
                  'an explicit commit or tag, not just "latest"'
    tags = ['repeatability']

    def matchtask(self, file, task):
        return (task['action']['__ansible_module__'] == 'git' and
                task['action'].get('version', 'HEAD') == 'HEAD')
