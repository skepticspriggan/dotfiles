#!/usr/bin/env bash

set -euxo pipefail

INPUT_FILEPATH=$1
OUTPUT_FILEPATH="$EXPORT_DIRECTORY/$(basename "$1").pdf"

pandoc $INPUT_FILEPATH -o $OUTPUT_FILEPATH \
  --pdf-engine=xelatex \
  --bibliography=$NOTES_DIRECTORY/7-source/citations.bib \
  --filter pandoc-citeproc \
  --csl=$NOTES_DIRECTORY/7-source/acs.csl
