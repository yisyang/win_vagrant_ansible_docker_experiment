#============================================================
#
# Just some custom .bashrc
#
#============================================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Read global bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Prevents accidentally clobbering files
alias mkdir='mkdir -p'

# Misc shortcuts
alias ..='cd ..'
alias du='du -kh'
alias df='df -kTh'
alias h='history'
alias j='jobs -l'
alias ls='ls -h --color'
alias ll="ls -lv --group-directories-first"

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

