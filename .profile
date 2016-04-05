# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# for COMPLETIONFILE in `find /usr/local/etc/bash_completion.d -type f -name "*bash"`;
for COMPLETIONFILE in `find /usr/local/etc/bash_completion.d -type f`;
do
    source $COMPLETIONFILE
done

# export PATH=~/bin:/usr/local/bin:/usr/local/heroku/bin:$PATH

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
   PATH="$HOME/bin:$PATH"
fi

LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

/usr/bin/ssh-agent $SHELL

