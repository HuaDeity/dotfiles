if command -q bat
    alias cat="bat"
else if command -q batcat
    alias cat="batcat"
end

if command -q eza
    alias ls='eza --group-directories-first'
end

if command -q git
    alias grt="cd (git rev-parse --show-toplevel; or echo '.')"
end

switch (uname -s)
    case Darwin
        alias keka="/Applications/Keka.app/Contents/MacOS/Keka --cli"
        alias gtower 'gittower $(git rev-parse --show-toplevel)'
end
