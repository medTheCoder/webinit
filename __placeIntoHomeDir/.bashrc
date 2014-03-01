# color prompt

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;31m\]\[\033[01;33m\]:\[\033[01;31m\]\w\$\[\033[01;37m\] '


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

