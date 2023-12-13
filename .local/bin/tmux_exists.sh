#!/usr/bin/env bash

tmux_session_exists() {
  pgrep -xo "tmux: server" >/dev/null && [[ -n "$(tmux ls | grep $1)" ]]
}
