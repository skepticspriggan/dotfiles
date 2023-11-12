#!/bin/bash

SESSION="tobias"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

SESSION_PATH="$REPOS_PATH/tobias"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 "editor"
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim .'

WINDOW="commander"

tmux new-window -n $WINDOW -c $SESSION_PATH

tmux split-window -v -c $SESSION_PATH
tmux split-window -h -c $SESSION_PATH
tmux selectp -t 1
tmux split-window -h -c $WORK_SCRIPTS_PATH

sleep 0.3
tmux send -t $SESSION:$WINDOW.4 'sudo service docker start; cd .docker && ./run.sh'
sleep 0.3
tmux send -t $SESSION:$WINDOW.1 'git status'
sleep 0.3
tmux send -t $SESSION:$WINDOW.3 'docker exec -it php-apache /bin/bash'
sleep 0.3
tmux send -t $SESSION:$WINDOW.2 './deploy-tobias-to-production.sh'

WINDOW="monitor"

tmux new-window -n $WINDOW -c $SESSION_PATH 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'docker exec -it php-apache /bin/bash -c "tail -f -n 100 /var/www/logs/app.log | grep "error""'

WINDOW="stage"

tmux new-window -n $WINDOW -c $SESSION_PATH 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-tobias-stage'

WINDOW="prod"

tmux new-window -n $WINDOW -c $SESSION_PATH 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-tobias-prod'

tmux attach -t $SESSION
