{ config, inputs, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.profiles.desktop;
in
{
  options.nyx.profiles.wsl = {
    enable = mkEnableOption "wsl profile";
  };

  config = mkIf cfg.enable {
    fonts = {
      fonts = with pkgs; [
        (
          nerdfonts.override {
            fonts = [ "JetBrainsMono" "Hack" "Meslo" "UbuntuMono" ];
          }
        )
      ];
    };
  };
}
