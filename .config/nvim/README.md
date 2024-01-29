# Neovim

Highly flexible and fast editor.

## Features

- Low start-up time
- Low input latency
- Autocompletion
- Goto definition
- Find references
- Fuzzy finding
- Formatting options per filetype

## Installation

Install a clipboard provider such as `xclip`:

```bash
sudo apt install xclip
```

Install build tools to compile plugins such as `treesitter`:

```bash
sudo apt-get install build-essential
```

Otherwise the following error will be shown:

```
No C compiler found! "cc", "gcc", "clang", "cl", "zig" are not executable.
```

Install ripgrep to search with grep in `telescope`:

```bash
sudo apt-get install ripgrep
```

## Credits

The configuration is inspired by the [kickstart-nvim](https://github.com/kdheepak/kickstart.nvim) package.
