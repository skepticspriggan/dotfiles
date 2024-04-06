#!/bin/bash

#set -euxo pipefail

. tmux_exists.sh
. tmux_switch.sh

SESSION="mail-queue"
 
if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REPOS_PATH/$SESSION"
if [ ! -d $SESSION_PATH ]; then
  git clone git@bitbucket.org-dev:custompixels/mail-queue.git $SESSION_PATH
fi
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim .' ENTER

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW.1 'git status' ENTER

tmux_switch $SESSION:1.1
