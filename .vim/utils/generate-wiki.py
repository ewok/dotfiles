#!/bin/env python
"""
    Generate missed links
"""

from __future__ import print_function
import argparse
import codecs
import re
import os
from os.path import dirname, join, isfile, splitext

def main():
    """
    main function
    """

    parser = argparse.ArgumentParser(description='Generate links')
    parser.add_argument('index', help='index page')

    args = parser.parse_args()

    current_links = set()
    wiki_path = dirname(args.index)

    found_links = {splitext(x)[0].decode(encoding="utf-8")
                   for x in os.listdir(wiki_path.encode(encoding="utf-8"))
                   if isfile(join(wiki_path, x))}

    with codecs.open(args.index, encoding="utf-8") as index:
        for string in index:
            for matched in re.findall(r"\[\[(.+?)\]\]", string):
                current_links.add(matched)

    missed_links = found_links - current_links
    empty_links = current_links - found_links

    if empty_links:
        print('Empty: ')
        for link in empty_links:
            print(link)

    print('New {} item[s]'.format(len(missed_links)))

    with codecs.open(args.index, mode='a', encoding="utf-8") as index:
        if missed_links:
            index.write('\n\n== Generated links ==\n')
            for link in missed_links:
                index.write(u"- [[{}]]\n".format(link))


if __name__ == "__main__":
    main()