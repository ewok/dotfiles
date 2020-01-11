import re
from ansiblelint import AnsibleLintRule
__author__ = 'https://github.com/bhavenger'


def get_keys_recursively(d):
    keys = []
    for key, value in d.iteritems():
        if isinstance(value, dict):
            results = get_keys_recursively(value)
            for result in results:
                keys.append(result)
        elif isinstance(value, (list, tuple)):
            for item in value:
                if isinstance(item, dict):
                    more_results = get_keys_recursively(item)
                    for another_result in more_results:
                        keys.append(another_result)
        else:
            keys.append(key)
    return keys


class UsingUnderscoreRule(AnsibleLintRule):
    id = 'R106'
    shortdesc = 'We\'re using underscores in variable names'
    description = ''
    tags = ['formatting']

    def is_valid(self, name):
        return re.match('^[\w\d_]*$', name)

    def matchplay(self, file, play):
        result = []
        if file['type'] == 'playbook' and 'vars' in play.keys():
            for k in get_keys_recursively(play):
                if not self.is_valid(k):
                    result.append(({'variable\'s name': k}, self.shortdesc))
            return result

        elif file['type'] == 'playbook' and 'group_vars' in file['path']:
            for k in get_keys_recursively(play):
                if not self.is_valid(k):
                    result.append(({'variable\'s name': k}, self.shortdesc))
            return result

        return result
