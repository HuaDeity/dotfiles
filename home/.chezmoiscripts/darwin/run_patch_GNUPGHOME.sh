#!/bin/bash

TARGET_FILE="/usr/local/MacGPG2/libexec/fixGpgHome"
OLD_LINE='GNUPGHOME=${GNUPGHOME:-$HOME/.gnupg}'
NEW_LINE='GNUPGHOME=${GNUPGHOME:-$HOME/.local/share/gnupg}'

# Check 1: Target file exists
if [[ ! -f "$TARGET_FILE" ]]; then
  echo "ERROR: Target script not found: $TARGET_FILE"
  exit 1
fi

# Check 2: Already patched?
if grep -qF -- "$NEW_LINE" "$TARGET_FILE"; then
  echo "INFO: Already patched. No changes made."
  exit 0
fi

# Check 3: Contains the line to patch?
if ! grep -qF -- "$OLD_LINE" "$TARGET_FILE"; then
  echo "ERROR: Original setting line not found in $TARGET_FILE. Cannot patch."
  exit 1
fi

# Attempt to patch the file
# Escape characters in OLD_LINE and NEW_LINE for sed
SED_OLD_LINE=$(printf '%s\n' "$OLD_LINE" | sed -e 's/[\/&]/\\&/g')
SED_NEW_LINE=$(printf '%s\n' "$NEW_LINE" | sed -e 's/[\/&]/\\&/g')

# Use sudo for sed -i as the file is likely system-protected
if sudo sed -i.bak "s/$SED_OLD_LINE/$SED_NEW_LINE/" "$TARGET_FILE"; then
  echo "SUCCESS: Patched $TARGET_FILE."
  echo "(Backup created: $TARGET_FILE.bak)"

  # Execute the patched script
  echo "Executing the patched script: $TARGET_FILE..."
  # Note: This runs the script as the current user after patching.
  # The script itself might have internal logic regarding user context (like runAsUser).
  if "$TARGET_FILE"; then
    echo "INFO: Script executed successfully."
    exit 0
  else
    echo "WARNING: Script execution failed after patching (exit code $?). Check $HOME/Library/Logs/gpg-home-fixer.log for details."
    exit 1 # Exit with error if the script fails after patching
  fi
else
  echo "ERROR: Failed to patch $TARGET_FILE. Check permissions or sudo access."
  exit 1
fi
