#!/usr/bin/env python3
# coding: utf-8


import sys
import json
import urllib.request


DICT_API = 'http://dict-co.iciba.com/api/dictionary.php?w={word}&key={key}&type=json'
KEY = '107241AAB808EBDAAF6124EBFCEB5849'

WORD_BOOk = 'new_words.csv'


def lookup(word):
    url = DICT_API.format(word=word, key=KEY)
    try:
        resp = urllib.request.urlopen(url)
    except urllib.request.URLError as e:
        print('check your network')
    json_result = json.loads(resp.read().decode('utf-8'))
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
            with open(WORD_BOOk, mode='a', encoding='utf-8') as f:
                f.write('{}, {}, {}, {}\n'.format(word, sound, meaning['part'], mean))
    print('\n')

if __name__ == '__main__':
    lookup(sys.argv[1])
