#       .bashrc config file
#	pescobar AT cipf DOT es
#
#       "myprompt -l" or "myprompt -s" to show "long" or "short" path in the prompt
#       
#	unprivileged user shows blue prompt. root shows red prompt
#       
#       colored man pages
#	
#	improved bash_history to share same history in every shell and add date+time to every commmand in bash_history
#

# be sure to do to all this on interactive shells only
if [ "$PS1" ]; then

if [ -e /etc/bashrc ]; then
      . /etc/bashrc
fi

if [ -e /etc/bash.bashrc ]; then
       . /etc/bash.bashrc
fi

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin
PATH=${PATH}:/usr/games:/usr/local/bin:/usr/local/sbin
export PATH
export EDITOR=vim


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#print a fortune cookie
# requires fortune-mod , fortunes, fortunes-bofh-excuses packages
  if [ -e /usr/games/fortune ]; then
      if [ -z "$COLORTERM" ]; then
            /usr/games/fortune bofh-excuses
            else
            echo -en "\033[0;36m"
            /usr/games/fortune bofh-excuses
            echo -en "\033[0;37m"
      fi
fi
# ps aliases to see memory and cpu hogs - from http://www.billharlan.com/pub/papers/Debugging_GnuLinux.html
  function psc {
    ps --cols=1000 --sort='-%cpu,uid,pgid,ppid,pid' -e \
       -o user,pid,ppid,pgid,stime,stat,wchan,time,pcpu,pmem,vsz,rss,sz,args |
       sed 's/^/ /' | less
  }
  function psm {
    ps --cols=1000 --sort='-vsz,uid,pgid,ppid,pid' -e \
       -o user,pid,ppid,pgid,stime,stat,wchan,time,pcpu,pmem,vsz,rss,sz,args |
       sed 's/^/ /' | less
  }

# daily temp dir
#  export TD="$HOME/temp/`date +'%Y-%m-%d'`"
#  td(){
#    td=$TD
#    if [ ! -z "$1" ]; then
#      td="$HOME/temp/`date -d "$1 days" +'%Y-%m-%d'`";
#    fi
#    mkdir -p $td; cd $td
#    unset td
#  }



function myprompt
{
local NONE='\[\033[0m\]'
local WHITE_1='\[\033[0;1m\]'
local BLACK='\[\033[0;30m\]'
local GRAY='\[\033[1;30m\]'
local RED='\[\033[0;31m\]'
local LIGHT_RED='\[\033[1;31m\]'
local GREEN='\[\033[0;32m\]'
local LIGHT_GREEN='\[\033[1;32m\]'
local BROWN='\[\033[0;33m\]'
local YELLOW='\[\033[1;33m\]'
local BLUE='\[\033[0;34m\]'
local LIGHT_BLUE='\[\033[1;34m\]'
local PURPLE='\[\033[0;35m\]'
local LIGHT_PURPLE='\[\033[1;35m\]'
local CYAN='\[\033[0;36m\]'
local LIGHT_CYAN='\[\033[0;1;36m\]'
local LIGHT_GRAY='\[\033[0;37m\]'
local WHITE='\[\033[1;37m\]'


local BRACE_COLOR=$NONE
local LBRACE=$BRACE_COLOR[$BRACE_COLOR
local RBRACE=$BRACE_COLOR]$BRACE_COLOR
local SYMBOL
local PWD="\W"

if [ `whoami` = root ]; then
        #echo 'ROOT USER'
        SYMBOL="#"
else
        #echo 'NON-ROOT USER'
        SYMBOL="\$"
fi

if [[ $1 = "-h" || $1 = "--help" || $1 = "-?" ]]; then
        echo "USAGE:"
        echo "       myprompt [-s | -l]"
        echo " "
        echo "DESCRIPTION:"
        echo "      Format the PS1 prompt string to have colors."
        echo " "
        echo "      -s, --short"
        echo "            Default option shows the path as a truncated."
        echo " "
        echo "      -l, --long"
        echo "            Show the full path in the prompt.  Same as the pwd command"
        echo " "
        echo "      -?, -h, --help"
        echo "            Display usage options"
        echo " "
else

        if [[ $1 = "--short" || $1 = "-s" ]]; then
                PWD="\W"
        fi

        if [[ $1 = "--long" || $1 = "-l" ]]; then
                PWD="\w"
        fi
fi

## if load is high shows hostname in red
########################################

THRESHOLD_LOAD=200

ONE=$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\)/\1/" -e "s/ //g")
#   Apparently, "scale" in bc doesn't apply to multiplication, but does
#   apply to division.
ONEHUNDRED=$(echo -e "scale=0 \n $ONE/0.01 \nquit \n" | bc)

if [ $ONEHUNDRED -gt $THRESHOLD_LOAD ]
then
    HOST_COLOUR=$YELLOW
        # Light Red
else
    HOST_COLOUR=$YELLOW
        # Light green
fi

# end load function
########################################
# if load function is removed we lose $HOSTCOLOUR so in PS1 we  have to change $HOSTCOLOUR to $LIGHT_GREEN or $LIGHT_BLUE or something like that....



# root user > red prompt   |  unprivileged user > blue prompt
if [ `whoami` = root ]; then
PS1="$LBRACE\
$LIGHT_RED\u\
$RBRACE\
$LBRACE\
$HOST_COLOUR\h\
$RBRACE\
$LBRACE\
$LBUE$PWD\
$RBRACE\
$WHITE$SYMBOL$NONE "

else

PS1="$LBRACE\
$LIGHT_BLUE\u\
$RBRACE\
$LBRACE\
$HOST_COLOUR\h\
$RBRACE\
$LBRACE\
$LBUE$PWD\
$RBRACE\
$WHITE$SYMBOL$NONE "

fi

}

myprompt -l


# color man pages
###########################################
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# .bash_history
###########################################
#export HISTCONTROL=erasedups    # no duplicate entries
export HISTSIZE=100000          # big big history
shopt -s histappend             # append to history, don't overwrite it
HISTTIMEFORMAT="%m/%h - %H:%M:%S   " # add date+time to commands in history 

# Save and reload the history after each command finishes
# so we share same history on every shell
export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"



#alias
###########################################
alias ll="ls -l -h --color=auto"
alias ls="ls --color=auto"
alias lt='ls -ltr'
alias grep='grep --color'
alias g='grep --color'


fi
