#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="advent-of-code"

if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REPOS_PATH/advent-of-code"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW

sleep 0.3
tmux send -t $SESSION:$WINDOW.1 'nvim .'

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
tmux split-window -h -c $SESSION_PATH

sleep 0.3
tmux send -t $SESSION:$WINDOW.2 'grc go test -v --run Part1 .'
sleep 0.3
tmux send -t $SESSION:$WINDOW.2 'git status'
sleep 0.3

tmux_switch $SESSION:1.1
