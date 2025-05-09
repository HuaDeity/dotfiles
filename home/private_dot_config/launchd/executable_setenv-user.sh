#!/bin/sh
# Set all session-wide environment variables in one place

# For Fucking GPG Keychain
launchctl setenv GNUPGHOME "$HOME/.local/share/gnupg"
