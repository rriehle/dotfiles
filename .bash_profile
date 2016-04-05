if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias ls='ls -GFh'
alias ll='ls -GFhl'

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
#  Souce python environments via source ~/bin/souce-py*
# PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
# export PATH

# . /etc/bash_completion/django_bash_completion

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
