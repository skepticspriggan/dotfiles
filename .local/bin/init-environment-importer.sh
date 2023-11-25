#!/bin/bash

SESSION="importer"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
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

tmux new-window -n $WINDOW -c $SESSION_PATH
sleep 0.2
tmux send -t $SESSION:$WINDOW 'git status'

tmux attach -t $SESSION:1

