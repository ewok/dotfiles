# Copyright (c) 2016 Will Thames <will@thames.id.au>
from ansiblelint import AnsibleLintRule


class TaskHasNameRule(AnsibleLintRule):
    id = 'R103'
    shortdesc = 'All tasks should be named'
    description = 'All tasks should have a distinct name for readability ' + \
                  'and for --start-at-task to work'
    tags = ['readability']

    _nameless_tasks = ['meta', 'debug']

    def matchtask(self, file, task):
        return task.get('name', '') == '' and \
            task["action"]["__ansible_module__"] not in self._nameless_tasks
