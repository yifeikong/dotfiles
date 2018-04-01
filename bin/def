#!/usr/bin/env python3
# coding: utf-8


import sys
import json
import urllib.request


class WordLookupError(Exception):
    pass

class Word:

    DICT_API = 'http://dict-co.iciba.com/api/dictionary.php?w={word}&key={key}&type=json'
    KEY = '107241AAB808EBDAAF6124EBFCEB5849'

    def __init__(self, word, book='new_words.csv'):
        self.word = word
        self.book = book
        self.sound = ''
        self.meanings = []

    def lookup(self):
        url = self.DICT_API.format(word=self.word, key=self.KEY)
        try:
            resp = urllib.request.urlopen(url)
        except urllib.request.URLError as e:
            raise WordLookupError('check your network')
        json_result = json.loads(resp.read().decode('utf-8'))
        try:
            meanings = json_result['symbols'][0]['parts']
            self.sound = json_result['symbols'][0]['ph_am']
        except KeyError as e:
            raise WordLookupError('\nWord not found, check your spelling?\n')
        for meaning in meanings:
            m = meaning['part']
            m += ' '
            m += ';'.join(meaning['means'])
            self.meanings.append(m)

    def echo(self):
        print(u'\n\033[1m\033[4m{word}\033[0m  /{sound}/\n'.format(word=self.word, sound=self.sound))
        for m in self.meanings:
            print('\t' + m)
        print()

    def save(self):
        with open(self.book, mode='a', encoding='utf-8') as f:
            f.write('{}, {}, {}\n'.format(self.word, self.sound, ' '.join(self.meanings)))


if __name__ == '__main__':
    word = Word(sys.argv[1])
    try:
        word.lookup()
    except WordLookupError as e:
        print(e)
    word.save()
    word.echo()
