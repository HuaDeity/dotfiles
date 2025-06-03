function sshf
    if test -z "$argv[1]"
        echo "Usage: colorssh <user@host_or_alias> [command...]"
        return 1
    end

    set host_target $argv[1] # Capture the first argument as the host
    set remote_command $argv[2..-1] # Get remaining arguments as the remote command
    set -q flavor; or set -l flavor mocha # Ensure flavor is set, default to mocha if not

    # The -t flag is crucial for an interactive session
    # The double quotes around the remote command ensure local variable expansion
    ssh -t $host_target "set -gx flavor=$flavor" $remote_command
end
