#!/usr/bin/env bash

#set -euxo pipefail

xdotool type "$(cat .bash_snippets | fzf)"
