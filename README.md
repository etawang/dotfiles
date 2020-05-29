## Prerequisites
- [Homebrew](https://brew.sh/)

## Installation
To install the dotfiles, run
```
./install.sh
```
This will install the dotfiles and their dependencies.

Set both the Regular font and the Non-ASCII Font in "iTerm > Preferences > Profiles > Text" to use Meslo LG S Regular for Powerline.

## Updating
To update the installed dotfiles without attempting a full install of all dependencies, run
```
./install.sh --update
```

### About
The programs configured by this repo are bash, tmux, and nvim.

See `install.sh` for the full list of dependencies. A brief list:
  - python3
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [base16-shell](https://github.com/chriskempson/base16-shell)
  - [fzf](https://github.com/junegunn/fzf)
