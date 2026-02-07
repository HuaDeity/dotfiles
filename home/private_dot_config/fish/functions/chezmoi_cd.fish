function chezmoi_cd --description 'Change to the chezmoi source directory.'
    set -l chezmoi_source_dir (chezmoi source-path)
    if test -d "$chezmoi_source_dir"
        cd "$chezmoi_source_dir"
    else
        echo "Error: The chezmoi source directory does not exist." >&2
    end
end
