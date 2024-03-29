# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -d .* --color=auto'

# make dotfiles command available everywhere
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# rscreen: diretly jump into ssh sessions screen
rscreen() {
    ssh $1 -Yt screen -D -RR $2
}
rtmux() {
    ssh $1 -Yt tmux new-session -A -s $2
}
ssh_perlmutter() {
    ~/tools/perlmutter/sshproxy.sh -u dnoll
}
