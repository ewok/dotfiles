from ansiblelint import AnsibleLintRule
__author__ = 'https://github.com/bhavenger'


def get_role_name(path):
    s = path.split('/')
    index = s.index('roles') + 1
    return s[index]


class UsingPrefixesForRoleVariablesRule(AnsibleLintRule):
    id = 'R116'
    shortdesc = 'We\'re use role name prefixes in variable names'
    description = ''
    tags = ['formatting']

    def matchplay(self, file, play):
        result = []
        if file['type'] == 'playbook' and 'defaults' in file['path']:
            role_name = get_role_name(file['path'])
            for var in play:
                if '__' in var:
                    pass
                elif var.startswith(role_name + '_'):
                    pass
                else:
                    result.append(({'': var}, self.shortdesc))
        return result
