# Dotfiles

A repository of personal machine configuration files to easily share the same configuration between multiple machines and quickly setup new machines.

## Features

- _Minimal:_ Redundant information is removed to reduce the mental effort of finding relevant information (e.g. the prompt only shows the current path and not the username and hostname.)
- _Soft colors:_ Soft colors are used to make it easy to distinguish between different things without over-stimulating the brain.
- _Instant navigation:_ Navigation is as fast as can be at all levels:
    1. Most used applications have shortcuts (e.g. super + a switches to the write workspace with a terminal in i3, super + s switches to the read web workspace with a browser in i3.) No need to search using alt + tab or the activity overview.
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

Go to read web workspace with `super + 2`.

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

This is because your \$HOME folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care.

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

## Tools

**Text Editor**

The most important text editor assessment parameter is performance. The editor should boot almost instantly and the input latency must be very low. If it is not performant it breaks the workflow and leads to frustration.

Neovim is used as main text editor because of its customizability and performance.

Notepad++ is fast, but it is platform dependent, less customizable, and does not support vim motions. 

Vim is used on remote servers. It is not used as main editor because it is harder to customize. Neovim is a fork which uses a well documented and simple scripting language called Lua instead of the arcane Vimscript. It also has native LSP client support.

Visual Studio Code supports LSP clients, supports some vim motions, but is slow to start and react. The built-in terminal sometimes sends different commands than what is typed due to the lagging. Furthermore, the experience feels bloated instead of minimal. The built-in terminal is redundant. It is only helpful for people who cannot quickly switch between the editor and terminal.
