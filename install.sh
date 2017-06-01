#!/bin/bash
set -euf -o pipefail

CONFIG_DIR=~/.config

update_configs() {
  cp -r home/ ~/
  source ~/.bash_profile
  tmux source-file ~/.tmux.conf

  cp -r nvim "$CONFIG_DIR"/
  nvim +PlugInstall +qall
}

for opt in "$@"; do
  case $opt in
    --update)
      update_configs
      exit 0
      ;;
  esac
done

brew install neovim/neovim/neovim
brew install tmux
brew install reattach-to-user-namespace # Needed for copy and paste from tmux in Mac OSX sierra.
brew install ripgrep
brew install git bash-completion

# It's not necessary to install python and python3 just to get pip, but they're nice to have.
brew install python3 # Makes pip3 available
brew install python # Makes pip2 available
pip3 install --user neovim
pip2 install --user neovim

# Install base16-shell.
git clone https://github.com/chriskempson/base16-shell.git "$CONFIG_DIR"/base16-shell

# Install powerline fonts used by vim-airline.
git clone https://github.com/powerline/fonts.git "$CONFIG_DIR"/fonts
"$CONFIG_DIR"/fonts/install.sh

# Install fzf.
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc

# Install vim-plug.
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install tpm (tmux plugin manager).
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

update_configs

# Install base16-circus.
BASE16_CIRCUS_DIR="$CONFIG_DIR"/base16-circus-scheme
git clone git@github.com:stepchowfun/base16-circus-scheme.git "$BASE16_CIRCUS_DIR"
cp "$BASE16_CIRCUS_DIR"/circus/scripts/base16-circus.sh "$CONFIG_DIR"/base16-shell/scripts
cp "$BASE16_CIRCUS_DIR"/circus/colors/base16-circus.vim "$CONFIG_DIR"/nvim/plugged/base16-vim/colors
source ~/.bash_profile
base16_circus
