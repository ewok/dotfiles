from ansiblelint import AnsibleLintRule
__author__ = 'https://github.com/bhavenger'


class DefiningVariableOutsideOfGroupVarsRule(AnsibleLintRule):
    id = 'R114'
    shortdesc = 'We avoid define variables outside of group_vars.'
    description = "If needed - we can define variables that looking up in vault in playbooks."
    tags = ['general']

    def matchplay(self, file, play):
        result = []
        if file['type'] == 'playbook' and 'vars' in play.keys():
            if not play['vars']:
                return result
            for k, v in play['vars'].items():
                if '__' in k:
                    pass
                elif isinstance(v, str):
                    if 'lookup(\'vault\'' in v:
                        pass
                    else:
                        result.append(({k: v}, self.shortdesc))
                else:
                    result.append(({k: v}, self.shortdesc))
            return result
        return result
