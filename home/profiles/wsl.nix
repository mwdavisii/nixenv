{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.profiles.wsl;
in
{
  options.nyx.profiles.wsl = {
    enable = mkEnableOption "wsl profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brightnessctl
      playerctl
      feh
      lm_sensors
      rofi
      networkmanagerapplet
      synergy
      xdotool
      # eww
      deadhead-font
      vlc
    ];

    nyx.modules = {
      app.alacritty.enable = false;
      app.discord.enable = false;
      app.firefox.enable = false;
      app.wezterm.enable = false;
    };
  };
}
