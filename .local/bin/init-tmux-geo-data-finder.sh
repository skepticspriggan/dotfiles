#!/bin/bash

SESSION="geo-data-finder"

if pgrep -xo "tmux: server" >/dev/null && [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  if [ "$TERM_PROGRAM" = tmux ]; then
    tmux switch-client -t $SESSION
  else
    tmux attach -t $SESSION
  fi
  exit 1
fi

SESSION_PATH="$REPOS_PATH/geo-data-finder"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim .' ENTER

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
tmux split-window -h -c $SESSION_PATH
tmux split-window -v -c $SESSION_PATH

sleep 0.3
tmux send -t $SESSION:$WINDOW.1 './vendor/bin/phpunit' ENTER
sleep 0.3
tmux send -t $SESSION:$WINDOW.2 'git status'
sleep 0.3
tmux send -t $SESSION:$WINDOW.3 'composer update'

if [ "$TERM_PROGRAM" = tmux ]; then
  tmux switch-client -t $SESSION:2.2
else
  tmux attach -t $SESSION:2.2
fi
