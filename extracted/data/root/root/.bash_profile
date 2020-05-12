# We just logged in by typing a password, or using ssh, and our shell is bash.

# Set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Load .bashrc if it exists, this is bash and we are interactive.
if [ -n "$BASH_VERSION" -a -f "$HOME/.bashrc" ]; then
    [[ $- = *i* ]] && source "$HOME/.bashrc"
fi
