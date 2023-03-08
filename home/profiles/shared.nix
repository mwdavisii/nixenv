{ config, lib, pkgs, ... }:

with lib;
let cfg = config.nyx.profiles.common;
in
{
  options.nyx.profiles.common = { enable = mkEnableOption "common profile"; };

  config = mkIf cfg.enable {
    home = {
      enableDebugInfo = true;
      packages = with pkgs; [
        which
        moreutils
        wget
        tree
        htop
        bottom
        unzip
        zip
        stdman
        ripgrep
        exa
        fd
        sd
        dua
        procs
        git-crypt
      ];
    };

    # Manage home-manager with home-manager (inception)
    programs.home-manager.enable = true;

  };
}
