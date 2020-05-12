# This is the individual per-interactive-shell startup file.

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options.
HISTCONTROL=ignoreboth

# Set a default environment.
export VERSION_CONTROL=numbered
export EDITOR=/usr/bin/vim
eval `dircolors $HOME/.DIR_COLORS`

# Aliases
alias vi='/usr/bin/nvim'
alias ls='ls -F --color=auto'

# Set a fancy color prompt
PS1PREFIX="$HOSTNAME:"
if test -n "$SCHROOT_SESSION_ID" -o ! -e /etc/schroot/schroot.conf; then
  if test -n "$SCHROOT_SESSION_ID"; then
    PS1PREFIX="$HOSTNAME-$(echo $SCHROOT_SESSION_ID | sed -e 's/-.*//'):"
  elif echo "$(file $(readlink --canonicalize-existing $(ldd /bin/ls | grep 'libc.so.6 =>' | sed -e 's/.*=> //;s/ .*//')))" | grep "32-bit" >/dev/null; then
    PS1PREFIX="$HOSTNAME-32:"
  else
    PS1PREFIX="$HOSTNAME-64:"
  fi
fi
PS1=$PS1PREFIX'\[\e[35m\]\w\[\e[32`if [ $EUID = 0 ]; then echo ";7"; fi`m\]>\[\e[30;47;0m\]'

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Allow using vi commands on the bash prompt.
set -o vi

# Show aliases and bash functions when invoking `which`.
function which()
{
  (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}
