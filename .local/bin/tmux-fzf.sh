#!/usr/bin/env bash

#set -euxo pipefail

if [[ $# -eq 1 ]]; then
  project=$1
else
  project=$(cat ~/.config/tmux/projects.txt | fzf)
fi

if [[ -z $project ]]; then
    exit 0
fi

init-tmux-$project.sh
