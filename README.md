# Dotfiles

A repository of personal machine configuration files to easily share the same configuration between multiple machines and quickly setup new machines.

## Features

- _Minimal:_ Redundant information is removed to reduce the mental effort of finding relevant information (e.g. the prompt only shows the current path and not the username and hostname.)
- _Soft colors:_ Soft colors are used to make it easy to distinguish between different things without over-stimulating the brain.
- _Instant navigation:_ Navigation is as fast as can be at all levels:
    1. Most used applications have shortcuts (e.g. alt + 1 switches to the write workspace with a terminal in i3, alt + 2 switches to the read web workspace with a browser in i3.) No need to search using alt + tab or the activity overview.
    2. Inside the terminal most used sessions have shortcuts (e.g. tmux prefix + N switches to the notes session in tmux.) Inside the browser most used tabs are have shortcuts (e.g. ctrl + 1 for tab marked first.)
    3. Inside the editor most used files have shortcuts (ctrl + h switches to file marked as first in nvim.) 
- _Machine independent:_ Reasonable defaults are kept to make working on other machines almost as smooth as personal ones.

## Usage Examples

_Copy output of terminal command into another terminal_

Copy output of command to system clipboard without newlines by piping it into the `c` alias:

```
pwd | c
```

Paste output of command into other terminal with `ctrl + shift + v`.

_Copy text from tmux in the read workspace to the browser in the read web workspace_

Enter copy mode with `prefix + [`.

Use vim motions to go to the desired text.

Select text using visual mode with `V` to select whole line or `v` to select characters within a line.

Copy the text into the system clipboard with `y`.

Go to read web workspace with `alt + 2`.

Paste the text into the browser with `ctrl + v`.

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
dgit config --local user.name = "Skeptic Spriggan"
dgit config --local user.email = "skepticspriggan@protonmail.com"
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
