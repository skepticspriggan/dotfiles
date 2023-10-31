# Dotfiles

A repository of personal machine configuration files to easily share the same configuration between multiple machines and quickly setup new machines.

## Features

- _Minimal:_ Redundant information is removed to reduce the mental effort of finding relevant information (e.g. the prompt only shows the current path and not the username and hostname.)
- _Soft colors:_ Soft colors are used to make it easy to distinguish between different things without over-stimulating the brain.

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
