#!/bin/bash

SESSION="rijnland-dev"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

SESSION_PATH="~/web/application"
ssh -tt s2-rijnland "tmux -2 new-session -d -s $SESSION -c $SESSION_PATH" 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
tmux send -t $SESSION:$WINDOW 'vim README.md' 

tmux attach -t $SESSION

