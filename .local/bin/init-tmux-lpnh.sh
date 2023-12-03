#!/bin/bash

SESSION="lpnh"
SESSION_PATH="$REMOTE_REPOS_PATH/lpnh"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'sshfs s2-lpnh:/home/landbouwnh/domains/dev.landbouwportaalnoordholland.nl/application /home/tim/repos-remote/lpnh -o cache=yes,kernel_cache,compression=no -v'

WINDOW="dev"

tmux new-window -n $WINDOW -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-lpnh'

WINDOW="prod"

tmux new-window -n $WINDOW -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-lpnh'

tmux attach -t $SESSION
