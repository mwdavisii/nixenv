{
  description = ''
    Nyx is the personal configuration. This repository holdes .dotfile configuration as well as both nix (with
    home-manager) and nixos configurations.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/nur";
    #nur.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;

    # Overlays
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    neovim-flake.url = "github:neovim/neovim?dir=contrib";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs";

    nushell-src.url = "github:nushell/nushell";
    nushell-src.flake = false;

    # eww.url = "github:elkowar/eww";
  };

  outputs = { self, ... }@inputs:
    with self.lib;
    let
      systems = [ "x86_64-linux" ];
      foreachSystem = genAttrs systems;
      pkgsBySystem = foreachSystem (
        system:
        import inputs.nixpkgs {
          inherit system;
          config = import ./nix/config.nix;
        }
      );
    in
    rec {
      inherit pkgsBySystem;
      lib = import ./lib { inherit inputs; } // inputs.nixpkgs.lib;
      
      homeManagerConfigurations = mapAttrs' mkHome {
        mwdavisii = { };
      };

      nixosConfigurations = mapAttrs' mkSystem {
        worklt = { };
        wsl = { };
      };

      # Convenience output that aggregates the outputs for home, nixos, and darwin configurations.
      # Also used in ci to build targets generally.
      top =
        let
          nixtop = genAttrs
            (builtins.attrNames inputs.self.nixosConfigurations)
            (attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel);
          hometop = genAttrs
            (builtins.attrNames inputs.self.homeManagerConfigurations)
            (attr: inputs.self.homeManagerConfigurations.${attr}.activationPackage);
          darwintop = genAttrs
            (builtins.attrNames inputs.self.darwinConfigurations)
            (attr: inputs.self.darwinConfigurations.${attr}.system);
        in
        nixtop // hometop // darwintop;
    };
}
