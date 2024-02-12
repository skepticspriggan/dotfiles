#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="importer"

if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REPOS_PATH/importer"
mkdir -p $SESSION_PATH
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.2
tmux send -t $SESSION:$WINDOW 'nvim .'

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.2
tmux send -t $SESSION:$WINDOW 'git status'

tmux_switch $SESSION:1.1
