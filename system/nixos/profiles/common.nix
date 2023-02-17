{ config, inputs, lib, pkgs, ... }:

with lib;
let
  nixConf = import ../../../nix/conf.nix;
in
{
  config = {
    boot = {
      # Enable running aarch64 binaries using qemu.
      binfmt.emulatedSystems = [ "aarch64-linux" ];

      # Clean temporary directory on boot.
      cleanTmpDir = true;

      # Enable support for nfs and ntfs.
      supportedFilesystems = [ "cifs" "ntfs" "nfs" ];
    };

    # This is deprecated. Use `networking.interface.<name>.useDHCP`
    networking.useDHCP = false;
    networking.networkmanager.enable = true;

    nix = {
      # inherit (nixConf) binaryCaches binaryCachePublicKeys;

      settings = {
        substituters = nixConf.binaryCaches;
        trusted-public-keys = nixConf.binaryCachePublicKeys;

        # Save space by hardlinking store files
        auto-optimise-store = true;

        allowed-users = [ "root" ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };

    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    services = {
      cron.enable = true;
      locate.enable = true;
    };

    # List of bare minimal requirements for a system to have to bootstrap from
    environment.systemPackages = with pkgs; [
      curl
      git
      pciutils
      vim
    ];
  };
}
