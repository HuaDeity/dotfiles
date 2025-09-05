{pkgs, ...}: {
  config = {
    environment = {
      systemPackages = [
        pkgs.fish
        pkgs.slurm
      ];
    };
  };
}
