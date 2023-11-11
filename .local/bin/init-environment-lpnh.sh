#!/bin/bash

SESSION="lpnh"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

WINDOW="dev"

tmux new-window -n $WINDOW 
tmux send -t $SESSION:$WINDOW 'ssh s2-lpnh'

WINDOW="prod"

tmux new-window -n $WINDOW 
tmux send -t $SESSION:$WINDOW 'ssh s2-lpnh'

tmux attach -t $SESSION
