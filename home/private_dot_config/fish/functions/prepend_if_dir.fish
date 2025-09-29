function prepend_if_dir --argument-names var path
    if test -d "$path"
        if set -q $var
            set $var "$path":$$var
        else
            set $var "$path"
        end
    end
end
