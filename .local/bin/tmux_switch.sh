#!/usr/bin/env bash

#set -euxo pipefail

tmux_switch () {
  if [ "$TERM_PROGRAM" = tmux ]; then
    tmux switch-client -t $1
  else
    tmux attach -t $1
  fi
}
