#!/usr/bin/env bash

set -euxo pipefail

echo "sync coarse repos"

for REPO in 'notes' \
  'notes-custom-pixels' \
  'qmk_firmware'
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
    git push
  fi
done

echo "sync fine grained repos"

for REPO in 'advent-of-code' \
  'authentication-attempt-limiter' \
  'authentication-log' \
  'betaallink' \
  'bootstrap' \
  'cmp-reference' \
  'cv' \
  'docs' \
  'file-handler' \
  'geo-data-finder' \
  'go-start' \
  'importer' \
  'ip-geolocator' \
  'request-log' \
  'script-deploy' \
  'script-rollback' \
  'tobias' \
  'tower-of-hanoi' \
  'update-trusted-ips' \
  'yii2' \
  'yii2-coding-standards' \
  'yii2-post-log-targets'
do
  if [ -z "$REPOS_PATH/$REPO" ]; then
    cd $REPOS_PATH/$REPO
    echo $REPO
    if [[ $(git status --porcelain) ]]; then
      echo "Changes"
      if [ -f ".git/MERGE_HEAD" ]; then
        echo "Merge conflict"
      else
        echo "Pull repo"
        git fetch
        if [ $(git rev-list HEAD...origin/master --count) != 0 ]; then
          git stash
          git pull
          git stash apply
          git push
        fi
      fi
    else
      echo "No changes"
      git pull
      git push
    fi
  fi
done

cd $HOME
echo "dotfiles"
DGIT="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
if [[ $($DGIT status --porcelain) ]]; then
  echo "Changes"
  if [ -f ".git/MERGE_HEAD" ]; then
    echo "Merge conflict"
  else
    echo "Pull repo"
    $DGIT stash
    $DGIT pull
    $DGIT stash apply
  fi
else
  echo "No changes"
  $DGIT pull
fi
