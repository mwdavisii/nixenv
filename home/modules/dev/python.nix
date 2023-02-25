{ config, lib, pkgs, ... }:

with lib;
let
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
in
{
  extraPackages = mkOption {
    description = "List of extra packages to be installed";
    type = with types; listOf package;
    default = with pkgs.python39Packages; [
      black
      jedi
      pip
      poetry
      pylint
      setuptools
    ];
  };
  config = {
    home.packages = with pkgs; [
      python39
      pipenv
    ] ++ cfg.extraPackages;
  };
}
