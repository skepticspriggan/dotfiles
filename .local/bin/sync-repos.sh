#!/usr/bin/env bash

set -euxo pipefail

for REPO in 'notes' \
  'notes-custom-pixels'
do
  cd $REPOS_PATH/$REPO
  echo $REPO
  if [[ $(git status --porcelain) ]]; then
    echo "Changes"
    if [ -f ".git/MERGE_HEAD" ]; then
      echo "Merge conflict"
    else
      echo "Sync repo"
      git add -A
      git commit -m "backup repo";
      git pull
      git push
    fi
  else
    echo "No changes"
    git pull
  fi
done
