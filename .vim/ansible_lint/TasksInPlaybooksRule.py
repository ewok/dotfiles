from ansiblelint import AnsibleLintRule


class TasksInPlaybooksRule(AnsibleLintRule):
    id = 'R110'
    shortdesc = 'Don\'t use tasks into playbooks'
    description = 'Instead of tasks, use pre_tasks/post_tasks'
    tags = ['formatting']

    def matchplay(self, file, play):
        result = []
        if file['type'] == 'playbook' and 'tasks' in play and 'roles' not in file['path']:
            result.append(('Founded tasks in %s' % file['path'], '\n'.join([self.shortdesc, self.description])))
        return result
