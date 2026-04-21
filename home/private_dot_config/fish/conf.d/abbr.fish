if command -q bat
    abbr -a --position anywhere -- --help '--help | bat -plhelp'
    abbr -a --position anywhere -- -h '-h | bat -plhelp'
end

abbr ll "ls -l --git"
abbr l "ll -a"
abbr lr "ll -T"
abbr lx "ll -sextension"
abbr lk "ll -ssize"
abbr lt "ll -smodified"
abbr lc "ll -schanged"
