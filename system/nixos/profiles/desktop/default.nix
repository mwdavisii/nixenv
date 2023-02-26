{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.profiles.desktop;

  wmList = [ "awesome" ];
  deList = [ "gnome" "plasma5" ];
in
{
  imports = [
    ../common.nix

  ];
  options.nyx.profiles.desktop = {
    laptop = mkOption {
      description = "Enable features for a laptop (trackpad, battery, etc...)";
      type = types.bool;
      default = false;
    };

    flavor = mkOption {
      description = "Desktop environment flavor";
      type = types.enum (wmList ++ deList);
      default = "awesome";
    };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    nixpkgs.config.allowUnfree = true;

    # Sound setting
    sound.enable = true;

    environment.systemPackages = with pkgs; [
      pamixer
      firefox
      chromium
      vscode
    ];
    
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    # Configure keymap in X11
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };
    
    services = {
      cron.enable = true;
      locate.enable = true;
    };

    networking.networkmanager.enable = true;
  };
}
