#!/bin/bash

SESSION="rijnland"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

tmux -2 new-session -d -s $SESSION

WINDOW="dev"

tmux rename-window -t $SESSION:1 $WINDOW
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland'

WINDOW="prod"

tmux new-window -n $WINDOW 
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland' ENTER

tmux attach -t $SESSION
