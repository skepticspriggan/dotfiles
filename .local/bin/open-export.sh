#!/usr/bin/env bash

INPUT_FILEPATH=$1
INPUT_DIRECTORY=$(dirname "$1")
OUTPUT_FILENAME="$(basename "$1").pdf"

zathura "$EXPORT_DIRECTORY/$OUTPUT_FILENAME"
