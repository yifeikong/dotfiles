#!/usr/bin/env python
# coding: utf-8


import sys
import json
import urllib2 as urllib


DICT_API = 'http://dict-co.iciba.com/api/dictionary.php?w={word}&key={key}&type=json'
KEY = '107241AAB808EBDAAF6124EBFCEB5849'


def lookup(word):
    url = DICT_API.format(word=word, key=KEY)
    try:
        resp = urllib.urlopen(url)
    except urllib.URLError as e:
        print('check your network')
    json_result = json.loads(resp.read())
    try:
        meanings = json_result['symbols'][0]['parts']
        sound = json_result['symbols'][0]['ph_am']
    except KeyError as e:
        print('\nWord not found, check your spelling?\n')
        return
    print(u'\n\033[1m\033[4m{word}\033[0m  /{sound}/\n'.format(word=word, sound=sound))
    for meaning in meanings:
        print(meaning['part'])
        for mean in meaning['means']:
            print('\t' + mean)
    print('\n')

if __name__ == '__main__':
    lookup(sys.argv[1])
