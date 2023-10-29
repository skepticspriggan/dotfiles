# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -f ~/.bash_completion ]
then
  . ~/.bash_completion
fi

alias bootstrap="init-environment-bootstrap.sh"
alias docs="init-environment-docs.sh"
alias file_handler="init-environment-file-handler.sh"
alias geo_data_finder="init-environment-geo-data-finder.sh"
alias notes="init-environment-notes.sh"
alias tobias="init-environment-tobias.sh"

alias l="ls -larth"
alias c="clear"

if [ -f $HOME/.profile_$HOSTNAME ]; then
  source $HOME/.profile_$HOSTNAME
fi
