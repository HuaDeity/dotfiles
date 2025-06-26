if command -q bat; or command -q batcat
    abbr -a --position anywhere -- --help '--help | cat -plhelp'
    abbr -a --position anywhere -- -h '-h | cat -plhelp'
end

abbr ll "ls -l --git"
abbr l "ll -a"
abbr lr "ll -T"
abbr lx "ll -sextension"
abbr lk "ll -ssize"
abbr lt "ll -smodified"
abbr lc "ll -schanged"
