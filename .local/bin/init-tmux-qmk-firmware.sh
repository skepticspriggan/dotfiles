#!/bin/bash

# set -euxo pipefail

SESSION="qmk-firmware"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  if [ "$TERM_PROGRAM" = tmux ]; then
    tmux switch-client -t $SESSION
  else
    tmux attach -t $SESSION
  fi
  exit 1
fi


SESSION_PATH="$REPOS_PATH/qmk_firmware"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.2
tmux send -t $SESSION:$WINDOW 'nvim keyboards/crkbd'

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.2
tmux send -t $SESSION:$WINDOW 'qmk compile -kb crkbd/rev1 -km skepticspriggan -e CONVERT_TO=elite_pi'


if [ "$TERM_PROGRAM" = tmux ]; then
  tmux switch-client -t $SESSION:1
else
  tmux attach -t $SESSION:1
fi
