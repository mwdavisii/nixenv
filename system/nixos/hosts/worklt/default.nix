{ ... }:

{
  imports = [ ./machine-specific.nix ];

  networking.interfaces.wlp3s0.useDHCP = true;

  users.users.root = {
    users.users."root".hashedPassword = config.users.users."root".initialHashedPassword;
    # Otherwise WSL fails to login as root with "initgroups failed 5"
    extraGroups = [ "root" ];
  };


  nyx = {
    modules = {
      user.home = ./home.nix;

      bluetooth.enable = true;
      caps.enable = true;
      disk.enable = true;
      nvidia = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      yubikey.enable = true;
    };

    profiles = {
      desktop = {
        enable = true;
        laptop = true;
        flavor = "gnome";
      };
    };
  };

  programs.steam.enable = true;
  hardware.opengl.driSupport32Bit = true;
}
