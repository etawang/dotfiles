if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

. /usr/local/etc/bash_completion.d/git-completion.bash
. /usr/local/etc/bash_completion.d/git-prompt.sh
. /usr/local/etc/bash_completion.d/tmuxinator.bash

# Make the prompt look like this:
# Mon Apr 02 12:06:50 airbnb (master) $
export PS1="\[\033[01;93m\]\d \t \[\033[31m\]\W\[\033[34m\]\$(__git_ps1) \$ \[\033[00m\]"

export CLICOLOR=1
export LS_COLORS="$LS_COLORS:'di=0;44:'"
export FZF_DEFAULT_COMMAND='rg --hidden --files -g "!\*.git/\*"'

# Used by tmuxinator to detect default editor.
export EDITOR='nvim'

# Used by Java.
export JAVA_HOME=$(/usr/libexec/java_home)

# Vi mode for bash
set -o vi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export PATH="$HOME/.rbenv/bin:~/.local/bin:$JAVA_HOME/bin:$PATH"
export PATH=$PATH:~/dev/sysops/optica_tools/

al() {
  airlab "$@"
}

# Git alias for rebasing current branch onto remote branch
gre() {
  branch="master"
  if [ "$1" ]; then
    branch="$1"
  fi
  git fetch origin && git rebase origin/"$branch"
}

gamp() {
  me="Esther"
  if git log --pretty=format:"%an" -1 | grep "$me" > /dev/null
  then
    git commit -a --amend --no-edit && git push -f
  else
    echo "Looks like the most recent commit was not authored by $me. Make a new commit and try again."
  fi
}

gco() {
  target_branch="master"
  if [ "$1" ]; then
    target_branch="$1"
  fi
  base_branch="master"
  if [ "$2" ]; then
    base_branch="$2"
  fi
  if ! git show-ref --verify --quiet refs/heads/"$target_branch"
  then
    echo "Could not find local branch $target_branch"
    return
  fi
  git checkout "$target_branch" && gre "$base_branch"
}

gcod() {
  current_branch="$(git rev-parse --abbrev-ref HEAD)"
  base_branch="master"
  if [ "$2" ]; then
    base_branch="$2"
  fi
  git checkout "$1"
  git branch -D "$current_branch"
  gre "$base_branch"
}

ssh-role() {
  if [ -z "$1" ]; then
    echo "Usage: ssh-role <optica_role>"
  fi
  al rekey && optica role=^"$1"$ | sed -n 1p | xargs -o ssh
}

eval "$(rbenv init -)"
