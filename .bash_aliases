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

# Commands on lxplus
work_mlpf () {
    cd ~/projects/GlobalParticleFlowStudies/
    setupATLAS
    cd build
    asetup Athena,main,latest
    cd ../run/
    echo "Now copy: cp ../athena/GlobalParticleFlow/SubstructureStudies/python/PFRunCalibHitDecorator_PFlowReco_ESDtoAOD_addCPData_mc21.py ."
    echo "Then start: python PFRunCalibHitDecorator_PFlowReco_ESDtoAOD_addCPData_mc21.py"
}

kscreen(){
    if [[ -z "$1" ]]; then #if no argument passed
        k5reauth -f -i 3600 -p dnoll -k /afs/cern.ch/user/d/dnoll/tokens/dnoll.keytab -- screen -D -RR hh
    else #pass the argument as the tmux session name
        k5reauth -f -i 3600 -p dnoll -k /afs/cern.ch/user/d/dnoll/tokens/dnoll.keytab -- screen -D -RR $1
    fi
}

tunnel () {
    ./tools/vscode/code tunnel
}
