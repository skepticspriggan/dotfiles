#!/usr/bin/env bash

set -euxo pipefail

INPUT_FILEPATH=$1
INPUT_DIRECTORY=$(dirname "$1")
OUTPUT_FILEPATH="$EXPORT_DIRECTORY/$(basename "$1").pdf"

pandoc $INPUT_FILEPATH -o $OUTPUT_FILEPATH \
  --pdf-engine=xelatex \
  --variable geometry:margin=2.5cm \
  --bibliography=$NOTES_DIRECTORY/7-source/citations.bib \
  --citeproc \
  --csl=$NOTES_DIRECTORY/7-source/acs.csl \
  --resource-path=$INPUT_DIRECTORY \
  --lua-filter ~/.local/bin/highlight.lua
