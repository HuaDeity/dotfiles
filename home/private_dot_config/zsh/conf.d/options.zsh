# Set general Zsh options.
setopt COMBINING_CHARS       # Combine 0-len chars with the base character (eg: accents).
setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.
setopt BEEP
unsetopt MAIL_WARNING        # Don't print a warning message if a mail file has been accessed.

# Set Zsh options related to job control.
setopt AUTO_RESUME           # Attempt to resume existing job before creating a new process.
setopt LONG_LIST_JOBS        # List jobs in the long format by default.
setopt NOTIFY                # Report status of background jobs immediately.

