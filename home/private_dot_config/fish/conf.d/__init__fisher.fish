if status is-interactive
    if ! functions --query fisher
        curl -sL https://git.io/fisher | source && fisher update
    end
end
