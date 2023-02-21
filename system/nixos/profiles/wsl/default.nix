{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.profiles.wsl;
  nixos-wsl = import ./nixos-wsl;

  wmList = [ "awesome" ];
  deList = [ "gnome" "plasma5" ];
in
{
  imports = [
    nixos-wsl.nixosModules.wsl

  ];
  options.nyx.profiles.wsl = {
    laptop = mkOption {
      description = "Enable features for a laptop (trackpad, battery, etc...)";
      type = types.bool;
      default = false;
    };

    flavor = mkOption {
      description = "WSL environment flavor";
      type = types.enum (wmList ++ deList);
      default = "awesome";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    wsl = {
        enable = true;
        automountPath = "/mnt";
        defaultUser = "nixos";
        startMenuLaunchers = true;
        docker-desktop.enable = true;
    };
  };
}
