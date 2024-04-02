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
ssh_lxplus() {
    kinit -f dnoll@CERN.CH
}

# Commands on Perlmutter
work_doubleaecwola () {
    module load python
    conda activate perlmutterdnoll
    cd ~/projects/anomaly_detection/doublecwola/DoubleAECWOLA/
    source setup.sh
}
work_recast_demo () {
    module load python
    conda activate perlmutterdnoll
    cd ~/projects/recast/lhco_cwola/CWoLa-Hunting
    source setup.sh
}
work_haxad () {
    module load python
    conda activate permutterdnoll
    cd ~/projects/anomaly_detection/atlas_analysis_new/code/haxad_demonstrator
}