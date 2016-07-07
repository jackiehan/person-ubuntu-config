# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#alias alsamixer to fixed alsamixer cannot open mixer error
alias alsamixer='/usr/bin/alsamixer -c 1'

#alias json pretty
alias jsonpretty='python -m json.tool'

alias docker-kill='docker kill $(docker ps -a -q)'
alias docker-rm-stop='docker rm $(docker ps -a -q)'
alias docker-rmi-notag='docker rmi $(docker images -q -f dangling=true)'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Some useful commands to use docker.
# Author: yeasy@github
# Created:2014-09-25

alias docker-pid="sudo docker inspect --format '{{.State.Pid}}'"
alias docker-ip="sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

#the implementation refs from https://github.com/jpetazzo/nsenter/blob/master/docker-enter
function docker-enter() {
    #if [ -e $(dirname "$0")/nsenter ]; then
    #Change for centos bash running
    if [ -e $(dirname '$0')/nsenter ]; then
        # with boot2docker, nsenter is not in the PATH but it is in the same folder
        NSENTER=$(dirname "$0")/nsenter
    else
        # if nsenter has already been installed with path notified, here will be clarified
        NSENTER=$(which nsenter)
        #NSENTER=nsenter
    fi
    [ -z "$NSENTER" ] && echo "WARN Cannot find nsenter" && return

    if [ -z "$1" ]; then
        echo "Usage: `basename "$0"` CONTAINER [COMMAND [ARG]...]"
        echo ""
        echo "Enters the Docker CONTAINER and executes the specified COMMAND."
        echo "If COMMAND is not specified, runs an interactive shell in CONTAINER."
    else
        PID=$(sudo docker inspect --format "{{.State.Pid}}" "$1")
        if [ -z "$PID" ]; then
            echo "WARN Cannot find the given container"
            return
        fi
        shift

        OPTS="--target $PID --mount --uts --ipc --net --pid"

        if [ -z "$1" ]; then
            # No command given.
            # Use su to clear all host environment variables except for TERM,
            # initialize the environment variables HOME, SHELL, USER, LOGNAME, PATH,
            # and start a login shell.
            #sudo $NSENTER "$OPTS" su - root
            sudo $NSENTER --target $PID --mount --uts --ipc --net --pid su - root
        else
            # Use env to clear all host environment variables.
            sudo $NSENTER --target $PID --mount --uts --ipc --net --pid env -i $@
        fi
    fi
}

export JAVA_HOME=/usr/lib/jvm/default-java/
export HADOOP_INSTALL=/usr/local/apps/bigData/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN=$HADOOP_INSTALL
export PATH=$PATH:/usr/local/apps/j2objc/j2objc-0.9.7/
export HostIP=$(facter ipaddress_eth0)
