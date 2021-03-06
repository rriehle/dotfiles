# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen) color_prompt=no;;
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

if [ -f ~/bin/git-prompt.sh ]; then
    . ~/bin/git-prompt.sh
fi

for COMPLETIONFILE in `find /usr/local/etc/bash_completion.d -type f`;
do
  source $COMPLETIONFILE
done 

alias ipythonqt='ipython qtconsole --pdb --pylab=inline'
alias ipython3qt='ipython3 qtconsole --pdb --pylab=inline'

#  Due to needing to use several versions of Python (3.4 for most current, 3.3 for Django) source one of  ~/bin/source*
# export PATH=~/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/bin:/usr/local/heroku/bin:$PATH

export PATH=~/bin:$PATH
export EDITOR=/usr/bin/vim
export RSYNC_RSH=/usr/bin/ssh
# export PS1='\u@\h:\w> '
export PS1='\u@\h:\w$(__git_ps1 " (%s)")\$ '
export PAGER=less
export LESS=-r

test -s ~/.alias && . ~/.alias
umask 0077

ulimit -n 2560

#  Should recapture $DIAPLAY variable for X11.
update_display() {
    good_display=$(netstat -an | /bin/grep 0\ [0-9,:,.]*:60..\  | awk '{print $4}' | tail -n 1)
    good_display=${good_display: -2}
    export DISPLAY=${HOSTNAME}:${good_display}.0
}


# # bash-git-prompt configuration
# # Set config variables first
# export GIT_PROMPT_ONLY_IN_REPO=1
# export GIT_PROMPT_THEME=Solarized
# 
# # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
# 
# # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
# # GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files
# 
# # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10
# 
# # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
# # GIT_PROMPT_END=$      # uncomment for custom prompt end sequence
# 
# if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#   source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
# fi

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs

#  Following line handled by soucing one of ~/bin/source-py*
#  source /Library/Frameworks/Python.framework/Versions/3.4/bin/virtualenvwrapper.sh

#
# http://hackercodex.com/guide/python-development-environment-on-mac-osx/
#

# pip should only run if there is a virtualenv currently activated
#export PIP_REQUIRE_VIRTUALENV=true

# cache pip-installed packages to avoid re-downloading
#export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Use syspip to use pip outside of virtualenv
#syspip(){
#   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
#}

# Required by the AWS CLI tools
export JAVA_HOME=$(/usr/libexec/java_home)

# Set the xterm title to the name of the current user    
echo -e '\033k'$USER'\033\\'

