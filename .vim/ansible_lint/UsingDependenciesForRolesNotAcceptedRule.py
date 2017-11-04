from ansiblelint import AnsibleLintRule
__author__ = 'https://github.com/bhavenger'


class UsingDependenciesForRolesNotAcceptedRule(AnsibleLintRule):
    id = 'R119'
    shortdesc = 'We aren\'t use role\'s dependencies'
    description = ''
    tags = ['general']

    def matchplay(self, file, play):
        result = []
        if file['type'] == 'playbook' and 'dependencies' in play:
            result.append(({'dependencies': play['dependencies']}, self.shortdesc))
        return result
