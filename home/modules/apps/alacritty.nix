{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.modules.app.alacritty;
in
{
  options.nyx.modules.app.alacritty = {
    enable = mkEnableOption "alacritty configuration";
    package = mkOption {
      description = "Package for alacritty";
      type = with types; nullOr package;
      default = pkgs.alacritty;
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];
  };
}
