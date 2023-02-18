{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.profiles.desktop;

  wmList = [ "awesome" ];
  deList = [ "gnome" "plasma5" ];
in
{
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
    system.stateVersion = "22.11"; # Did you read the comment?
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
    networking.networkmanager.enable = true;
    # Set your time zone.
    time.timeZone = "America/Chicago";
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
