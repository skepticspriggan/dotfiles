#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="finance"
 
if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$NOTES_DIRECTORY/2-personal/finance/"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="transactions"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim transaction.csv' ENTER

WINDOW="categories"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim -O {income,expense}-categories.txt' ENTER
sleep 0.3

tmux_switch $SESSION:1.1
