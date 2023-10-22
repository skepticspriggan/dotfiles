#!/bin/bash

SESSION="file-handler"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

SESSION_PATH="$REPOS_PATH/file-handler"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
tmux send -t $SESSION:$WINDOW 'nvim .'

WINDOW="commander"

tmux new-window -n $WINDOW -c $SESSION_PATH
tmux send -t $SESSION:$WINDOW './vendor/bin/phpunit' ENTER

tmux split-window -h
tmux send -t $SESSION:$WINDOW.2 'composer update'

tmux attach -t $SESSION:1

