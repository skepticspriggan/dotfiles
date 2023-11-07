#!/bin/bash
BASE_SOURCE_DIRECTORY="/media/tim/m-hdd-wd-1000-big-data-master"
YEAR=$(date +'%Y')
MONTH=$(date +'%m')
DAY=$(date +'%d')
BASE_BACKUP_DIRECTORY="/media/tim/p-ssd-sam/backup-large-data-${YEAR}-${MONTH}-${DAY}"

for DIRECTORY in 'books' \
  'lectures' \
  'videos/Bassie-En-Adriaan' \
  'videos/Montana' \
  'videos/MrNystrom' \
  'videos/Tapp-Brothers'
do
  SOURCE_DIRECTORY="${BASE_SOURCE_DIRECTORY}/${DIRECTORY}/*"
  BACKUP_DIRECTORY="${BASE_BACKUP_DIRECTORY}/${DIRECTORY}"
  echo $SOURCE_DIRECTORY
  echo $BACKUP_DIRECTORY
  mkdir -p $BACKUP_DIRECTORY
  cp -r $SOURCE_DIRECTORY $BACKUP_DIRECTORY
done

for FILE in 'videos/parkour-tutorial-climb-up.mp4' \
  'videos/hp-ps-rare-footage.mp4'
do
  SOURCE_FILE="${BASE_SOURCE_DIRECTORY}/${FILE}"
  echo $SOURCE_FILE
  cp $SOURCE_FILE $BASE_BACKUP_DIRECTORY
done
