#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="office"
 
if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$NOTES_DIRECTORY/1-office/"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="tasks-todo"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim tasks-todo.txt' ENTER

WINDOW="calendar-future"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim calendar-future.txt' ENTER

tmux_switch $SESSION:1.1
