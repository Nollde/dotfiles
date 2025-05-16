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
    conda activate perlmutterdnoll
    cd ~/projects/anomaly_detection/atlas_analysis_new/code/haxad_demonstrator
}

# Commands on lxplus
work_substructure () {
    cd ~/projects/agpf/CalibrationHitStudies
    setupATLAS
    asetup --restore
    source build/x86*/*setup.sh
    cd run
    echo "Now copy: cp ../athena/CalibrationHitStudies/share/run_substructure.py ." 
    echo "Then start: python run_substructure.py"
}

work_substructure_workflow () {
    cd ~/projects/agpf/CalibrationHitStudies/athena/CalibrationHitStudies/workflow/
    source setup.sh
}

build_athena () {
    cd ../build
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE -DATLAS_ENABLE_IDE_HELPERS=TRUE ../athena/Projects/WorkDir
    make
    cd ..
    source build/x86*/setup.sh
    cd run

}

work_mcjoboptions () {
    cd ~/projects/GlobalParticleFlowStudies/
    setupATLAS
    cd build
    asetup 23.6.32,AthGeneration  # For Derivation: Athena,main,latest
    cd ~/projects/mcjoboptions/generation
    source setup.sh
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

alias vinit="voms-proxy-init -voms atlas"
