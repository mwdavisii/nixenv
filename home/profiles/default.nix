{ lib, ... }:

{
  imports = [ ./common.nix ./desktop.nix ./wsl.nix ];

  config.nyx.profiles.common.enable = lib.mkDefault false;
}

