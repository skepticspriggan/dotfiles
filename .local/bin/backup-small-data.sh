#!/bin/bash
SOURCE_DIRECTORY="/media/tim/d-sam-ssd-500"
YEAR=$(date +'%Y')
MONTH=$(date +'%m')
DAY=$(date +'%d')
BACKUP_DIRECTORY="/media/tim/p-ssd-sam/backup-small-data-${YEAR}-${MONTH}-${DAY}"

cp -r $SOURCE_DIRECTORY $BACKUP_DIRECTORY
