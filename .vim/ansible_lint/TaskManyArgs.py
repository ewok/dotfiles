import re
from ansiblelint import AnsibleLintRule


class TaskManyArgs(AnsibleLintRule):
    id = 'R111'
    shortdesc = 'Use ":" YAML formatting'
    description = ''
    tags = ['task']

    _pattern_equal_splitted = re.compile('\w+=.*')
    _pattern_quoted_string = re.compile('"(.*?)"')
    _pattern_squoted_string = re.compile("'(.*?)'")

    def match(self, file, text):
        try:
            k, v = text.split(': ')
        except ValueError:
            return False
        if "# " in text:
            return False
        if self._pattern_quoted_string.search(v):
            return False
        if self._pattern_squoted_string.search(v):
            return False
        if ": >" in text:
            return True
        if 'regexp:' not in v:
            for i in v.split(" "):
                if self._pattern_equal_splitted.search(i):
                    return True
        return False
