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
alias dut='du -sh * 2>/dev/null | sort -rh | head -100'
alias df='df -kTh'
alias h='history'
alias j='jobs -l'
alias l='ls -hF --color --group-directories-first'
alias ll='ls -lhFA --color --group-directories-first'
alias lll='ls -lhFA --color --group-directories-first | less -r'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

