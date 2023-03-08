{ pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ];





  config = {

    nixpkgs.config.allowUnfree = true;
    # Boot
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    # Hardware
    hardware.pulseaudio.enable = false;
    hardware.opengl.driSupport32Bit = true;
    


    # Networking

    #networking.  # Enables wireless support via wpa_supplicant.
    networking = {
      #wireless.enable = true;
      networkmanager.enable = true;
      interfaces.wlp3s0.useDHCP = true;
      hostName = "mdaviswlt";
      networkmanager.unmanaged = [
      "*" "except:type:wwan" "except:type:gsm"
      ];
    };

    #Services
    services.printing.enable = true;
    
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "";
    };
    
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    services = {
      cron.enable = true;
      locate.enable = true;
    };
    
    #Security
    security.rtkit.enable = true;

    #Sound
    sound.enable = true;


    #Virtualization
    virtualisation.docker.enable = true;
  };
}