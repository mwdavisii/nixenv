{ lib, ... }:

{
  imports = [ ./shared.nix ./desktop.nix];

  config.nyx.profiles.common.enable = lib.mkDefault false;
}

