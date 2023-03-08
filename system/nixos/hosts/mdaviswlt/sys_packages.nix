{ ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    pamixer
    firefox
    chromium
    vscode
    awscli2
    kubectl
    bind-utils
    time-zone
    tracert
    zip
    unzip
    chrome-browser
    neofetch
  ];    
}