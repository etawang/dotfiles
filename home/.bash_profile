if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

. /usr/local/etc/bash_completion.d/git-completion.bash
. /usr/local/etc/bash_completion.d/git-prompt.sh

# Make the prompt look like this:
# Mon Apr 02 12:06:50 airbnb (master) $
export PS1="\[\033[01;93m\]\d \t \[\033[31m\]\W\[\033[34m\]\$(__git_ps1) \$ \[\033[00m\]"

export CLICOLOR=1
export LS_COLORS="$LS_COLORS:'di=0;44:'"
export FZF_DEFAULT_COMMAND='rg --hidden --files -g "!\*.git/\*"'

# Vi mode for bash
set -o vi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export PATH="$HOME/.rbenv/bin:~/.local/bin:$PATH"
export PATH=$PATH:~/dev/sysops/optica_tools/

al() {
  airlab "$@"
}

# Git alias for rebasing current branch onto remote branch
gre() {
  BRANCH="master"
  if [ "$1" ]; then
    BRANCH="$1"
  fi
  git fetch origin && git rebase origin/"$BRANCH"
}

gamp() {
  ME="Esther"
  if git log --pretty=format:"%an" -1 | grep "$ME" > /dev/null
  then
    git commit -a --amend --no-edit && git push -f
  else
    echo "Looks like the most recent commit was not authored by $ME. Make a new commit and try again."
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

  git checkout "$base_branch" &&
    gre "$base_branch" &&
    git checkout "$target_branch" &&
    git rebase "$base_branch"
}

eval "$(rbenv init -)"

