#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="log-time"

if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$NOTES_DIRECTORY/4-work/custom-pixels/logs/log-time/"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim log.csv' ENTER

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'make; make sort'
sleep 0.3

tmux_switch $SESSION:1.1
