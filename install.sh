#!/bin/bash
set -euf -o pipefail

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR=~/.config

update_configs() {
  echo "Configuring..."
  export TMUX=${TMUX:-''}
  cp -r "$DOTFILES_DIR"/home/ ~/
  source ~/.bash_profile
  tmux source-file ~/.tmux.conf

  cp -r "$DOTFILES_DIR"/nvim "$CONFIG_DIR"/
  cp -r "$DOTFILES_DIR"/tmuxinator "$CONFIG_DIR"/
  nvim +PlugInstall +qall
  echo "Done!"
}

for opt in "$@"; do
  case $opt in
    --update)
      update_configs
      exit 0
      ;;
  esac
done

# Make sure submodules are up to date.
# cd "$DOTFILES_DIR" && git submodule update --remote --init

# Install brew if it doesn't exist. TODO: gate with an if statement
brew -v > /dev/null 2> /dev/null
if [[ $? -ne 0 ]]; then
  echo "Homebrew is not installed. Installing..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Brew installing package dependencies..."
brew install neovim ||
  brew install tmux ||
  brew install reattach-to-user-namespace || # Needed for copy and paste from tmux in Mac OSX sierra.
  brew install ripgrep ||
  brew install git bash-completion ||
  brew install fd ||
  brew install wget ||
  # It's not necessary to install python and python3 just to get pip, but they're nice to have.
  brew install python3 || # Makes pip3 available
  brew install python || # Makes pip2 available
  pip3 install --user neovim ||
  pip2 install --user neovim ||
  echo "Done!"

echo "Installing other dependencies..."
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

# Install tmuxinator.
gem install tmuxinator
curl -fLo /usr/local/etc/bash_completion.d/tmuxinator.bash --create-dirs \
  https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash

echo "Done!"

update_configs

echo "Successfully installed dotfiles."
