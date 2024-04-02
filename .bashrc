# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
source ~/.bash_aliases
source ~/.slurmrc

# set default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# colorful prompt
PS1='\[\e]0;\w\a\]\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \[\033[31m\]$(date +%H:%M:%S) \[\033[01;36m\]> \[\033[00m\]'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

hostname=$(hostname)

if [[ $hostname == ml4hep* ]]; then
    # To use Software Module Farm:
    export MODULEPATH=$MODULEPATH:/global/software/sl-7.x86_64/modfiles/langs
    export MODULEPATH=$MODULEPATH:/global/software/sl-7.x86_64/modfiles/tools
    export MODULEPATH=$MODULEPATH:/global/software/sl-7.x86_64/modfiles/apps

    # To use system locally installed cuda:
    export PATH=/usr/local/cuda-11.2/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-11.2/lib64:$LD_LIBRARY_PATH

    # activate conda
    eval "$(/clusterfs/ml4hep_nvme2/bpnachman/anaconda3/bin/conda shell.bash hook)"
fi


# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/global/software/sl-7.x86_64/modules/langs/python/3.6/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/global/software/sl-7.x86_64/modules/langs/python/3.6/etc/profile.d/conda.sh" ]; then
        . "/global/software/sl-7.x86_64/modules/langs/python/3.6/etc/profile.d/conda.sh"
    else
        export PATH="/global/software/sl-7.x86_64/modules/langs/python/3.6/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [[ $hostname =~ ^n[0-9]{4}$ ]]; then
    # activate on lawrencium
    eval "$(/global/home/users/dnoll/tools/miniforge3/bin/conda shell.bash hook)"
fi

# Check if the hostname starts with "lxplus" and /etc/bashrc exists
if [[ $current_hostname == lxplus* ]] && [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# # Start ssh-agent automatically
# # Reuse existing ssh-agent or start a new one if necessary
# SSH_ENV="$HOME/.ssh-agent-thing"

# function start_agent {
#     echo "Initializing new SSH agent..."
#     ssh-agent > "${SSH_ENV}"
#     echo succeeded
#     chmod 600 "${SSH_ENV}"
#     . "${SSH_ENV}" > /dev/null
# }

# if [ -f "${SSH_ENV}" ]; then
#     . "${SSH_ENV}" > /dev/null
#     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || start_agent
# else
#     start_agent
# fi