#!/usr/bin/env python
# coding: utf-8

import json
import fileinput

string = ''
for line in fileinput.input():
    string += line

print(json.dumps(json.loads(string), ensure_ascii=False, indent=4))

