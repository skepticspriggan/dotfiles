# Dotfiles

A repository of personal machine configuration files to easily share the same configuration between multiple machines and quickly setup new machines.

## Features

- _Minimal:_ Redundant information is removed to reduce the mental effort of finding relevant information (e.g. the prompt only shows the current path and not the username and hostname.)
- _Soft colors:_ Soft colors are used to make it easy to distinguish between different things without over-stimulating the brain.
- _Instant navigation:_ Navigation is as fast as can be at all levels:
    1. Most used applications have shortcuts (e.g. alt + 1 switches to the terminal workspace in i3, alt + 2 switches to the browser workspace in i3.) No need to search using alt + tab or the activity overview.
    2. Inside the terminal most used sessions have shortcuts (e.g. ctrl + space + N switches to the notes session in tmux.) Inside the browser most used tabs are have shortcuts (e.g. ctrl + 1 for tab marked first.)
    3. Inside the editor most used files have shortcuts (space + 1 switches to file marked as first in nvim.) 

## Installation

Add the dotfiles alias to `.bashrc`:

```bash
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Ignore the repo folder:

```bash
echo ".dotfiles" >> .gitignore
```

Clone dotfiles into a bare repository in a "dot" folder of your `$HOME`:

```bash
git clone --bare git@bitbucket.org-skepticspriggan:skeptic-spriggan/dotfiles.git $HOME/.dotfiles
```

Checkout the content from the bare repository to your `$HOME`:

```bash
dgit checkout
```

The step above might fail with a message like:

```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```

This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care.

Re-run the check out if you had problems:

```bash
dgit checkout
```

Set the flag showUntrackedFiles to no on this specific (local) repository:

```bash
dgit config --local status.showUntrackedFiles no
```

Set a user name and email in the repo to enable development:

```bash
dgit config --global user.name = "Skeptic Spriggan"
dgit config --global user.email = "skepticspriggan@protonmail.com"
```

Set an alias to smoothen development:

```bash
echo "[alias]" >> $HOME/.dotfiles/config
echo "    push = push origin master" >> $HOME/.dotfiles/config
```

Create profile for new machine:

```bash
touch .profile_$HOSTNAME
```
