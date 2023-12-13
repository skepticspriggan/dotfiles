#!/usr/bin/env bash

tmux_exists() {
  pgrep -xo "tmux: server" >/dev/null && [[ -n "$(tmux ls | grep -w $1)" ]]
}
