## home directory

Contains `.tmux.conf` and `cmd_help`. Note that `.tmux.conf` includes plugins, which will have to be installed before the configuration will work as intended. The latter is a (probably incomplete) cheat sheet with a few reminders for less frequently used commands and shortcuts.

Install the following command line programs:
- [base16-shell](https://github.com/chriskempson/base16-shell)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

## nvim directory

The contents go in the `~/.conf/nvim` directory. Install the plugins with `vim-plug`.

### Fonts

vim-airline requires Powerline fonts. To install, run
```
git clone https://github.com/powerline/fonts.git
cd fonts && ./install.sh
```
Set both the Regular font and the Non-ASCII Font in "iTerm > Preferences > Profiles > Text" to use Meslo LG S Regular for Powerline.

### Color scheme

Get [base16-circus](https://github.com/stepchowfun/base16-circus-scheme).
