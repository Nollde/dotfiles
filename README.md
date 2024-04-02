# locals

## Description

Dotfiles for personal use. The setup follows [these instructions](https://www.atlassian.com/git/tutorials/dotfiles).


## Setup

First clone the `dotfiles` repository into your `$HOME` directory and set it up such that the dotfiles can be cloned into the `$HOME` area
```bash
# Clone dotfiles repository
git clone --bare git@github.com:Nollde/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
```

If you already have dotfiles set up, we push them into a backup directory
```bash
mkdir -p .dotfiles-backup && \
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dotfiles-backup/{}
```

then checkout the dotfiles again
```bash
dotfiles checkout
```

Do not show untracked files (everything else in the `$HOME` directory)
```bash
dotfiles config --local status.showUntrackedFiles no
```

## Use
```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```