#!/bin/bash

COMPLETION_DIR=$HOME/.dotfiles/completions

mkdir -p $COMPLETION_DIR

# django
curl https://raw.githubusercontent.com/django/django/master/extras/django_bash_completion \
    -o $COMPLETION_DIR/django_bash_completion.sh
