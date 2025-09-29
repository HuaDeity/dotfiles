# Insert a completion dir *after* the vendor block in $fish_complete_path
function add_completion_after_vendor --argument-names customdir
    # only if it exists and isn't already there
    if not test -d "$customdir"
        return
    end
    if contains -- "$customdir" $fish_complete_path
        return
    end

    # find the last index in $fish_complete_path that belongs to $__fish_vendor_completionsdirs
    set -l last_vendor 0
    for i in (seq (count $fish_complete_path))
        set -l d $fish_complete_path[$i]
        if contains -- "$d" $__fish_vendor_completionsdirs
            set last_vendor $i
        end
    end

    if test $last_vendor -gt 0
        # splice: [before vendor block] + custom + [after vendor block]
        set -l before $fish_complete_path[1..$last_vendor]
        set -l after
        if test (count $fish_complete_path) -gt $last_vendor
            set after $fish_complete_path[(math $last_vendor + 1)..-1]
        end
        set -g fish_complete_path $before "$customdir" $after
    else
        # fallback: put it before generated_completions if present, else prepend
        if set -l gen_idx (contains -i -- "$__fish_cache_dir/generated_completions" $fish_complete_path)
            set -l before $fish_complete_path[1..(math $gen_idx - 1)]
            set -l after $fish_complete_path[$gen_idx..-1]
            set -g fish_complete_path $before "$customdir" $after
        else
            set -g -p fish_complete_path "$customdir"
        end
    end
end
