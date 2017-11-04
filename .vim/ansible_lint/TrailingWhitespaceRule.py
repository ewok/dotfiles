# Copyright (c) 2013-2014 Will Thames <will@thames.id.au>
from ansiblelint import AnsibleLintRule


class TrailingWhitespaceRule(AnsibleLintRule):
    id = 'R104'
    shortdesc = 'Trailing whitespace'
    description = 'There should not be any trailing whitespace'
    tags = ['formatting']

    def match(self, file, line):
        return line.rstrip() != line
