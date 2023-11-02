#!/bin/bash

SESSION="dawbodem"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

SESSION_PATH="$REPOS_PATH/dawbodem"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
tmux send -t $SESSION:$WINDOW 'nvim .' ENTER

WINDOW="commander"

tmux new-window -n $WINDOW -c $SESSION_PATH

tmux send -t $SESSION:$WINDOW.1 'git status'

WINDOW="dev"
SESSION_PATH="~/domains/dev.daw-bodem.nl/application"

tmux new-window -n $WINDOW -c $SESSION_PATH 
tmux send -t $SESSION:$WINDOW 'ssh s2-dawbodem'

WINDOW="prod"
SESSION_PATH="~/domains/daw-bodem.nl/application"
tmux new-window -n $WINDOW -c $SESSION_PATH 
tmux send -t $SESSION:$WINDOW 'ssh s2-dawbodem' ENTER

tmux send -t $SESSION:$WINDOW 'init-environment.sh' ENTER

tmux attach -t $SESSION
