# Copyright (c) 2013-2014 Will Thames <will@thames.id.au>
import os

from ansiblelint import AnsibleLintRule
try:
    from ansible.utils.boolean import boolean
except ImportError:
    from ansible.utils import boolean


class CommandsInsteadOfModulesRule(AnsibleLintRule):
    id = 'R302'
    shortdesc = 'Using command rather than module'
    description = 'Executing a command when there is an Ansible module ' + \
                  'is generally a bad idea'
    tags = ['resources']

    _commands = ['command', 'shell']
    _modules = {'git': 'git', 'hg': 'hg', 'curl': 'get_url or uri', 'wget': 'get_url or uri',
                'svn': 'subversion', 'service': 'service', 'mount': 'mount',
                'rpm': 'yum or rpm_key', 'yum': 'yum', 'apt-get': 'apt-get',
                'unzip': 'unarchive', 'tar': 'unarchive', 'chkconfig': 'service',
                'rsync': 'synchronize', 'hostname': 'hostname', 'nmcli': 'nmcli',
                'patch': 'patch', 'sysctl': 'sysctl'}

    def matchtask(self, file, task):
        if task["action"]["__ansible_module__"] in self._commands and \
                task["action"]["__ansible_arguments__"]:
            executable = os.path.basename(task["action"]["__ansible_arguments__"][0])
            if executable in self._modules and \
                    boolean(task['action'].get('warn', True)):
                message = "{0} used in place of {1} module"
                return message.format(executable, self._modules[executable])
