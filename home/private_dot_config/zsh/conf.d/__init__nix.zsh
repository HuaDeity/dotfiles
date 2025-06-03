for profile in ''${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions)
done
