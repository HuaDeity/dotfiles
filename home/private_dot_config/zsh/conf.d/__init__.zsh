#
# __init__: This runs prior to any other conf.d contents.
#

# Apps
export EDITOR=nvim

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export VISUAL=nvim
else
  export VISUAL=zed
fi

