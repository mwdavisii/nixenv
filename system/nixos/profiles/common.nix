{ config, inputs, lib, pkgs, ... }:

with lib;
let
  nixConf = import ../../../nix/conf.nix;
in
{
  config = {
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

    # Set your time zone.
    time.timeZone = "America/Chicago";
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # List of bare minimal requirements for a system to have to bootstrap from
    environment.systemPackages = with pkgs; [
      curl
      git
      vim
    ];
  };
}
