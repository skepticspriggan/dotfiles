#!/bin/bash

SESSION="docs"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

SESSION_PATH="$REPOS_PATH/docs"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
tmux send -t $SESSION:$WINDOW 'nvim .' ENTER

WINDOW="commander"

tmux new-window -n $WINDOW -c $SESSION_PATH
tmux split-window -h -c $SESSION_PATH

tmux send -t $SESSION:$WINDOW.1 'git status'

tmux attach -t $SESSION:1.1

