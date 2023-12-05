#!/usr/bin/env bash

ls -t $EXPORT_DIRECTORY/*.pdf | head -n 1 | xargs zathura
