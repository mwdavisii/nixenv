{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.modules.dev.python;
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
in
{
  options.nyx.modules.dev.python = {
    enable = mkEnableOption "python configuration";

    extraPackages = mkOption {
      description = "List of extra packages to be installed";
      type = with types; listOf package;
      default = with pkgs.python39Packages; [
        black
        jedi
        pip
        python-env
        setuptools
        aiohttp # async HTTP
        beautifulsoup4 # web scraping
        folium # maps
        geopy # geographical data
        ipython # interactive shell
        jupyter # interactive notebooks
        matplotlib # plots
        networkx # graphs
        numpy # numerical computation
        pandas # data analysis
        pylint # static checking
        pwntools
        requests # HTTP library
        setuptools # setup.py
        z3 # Z3 theorem prover
      ];
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python39
      pipenv
    ] ++ cfg.extraPackages;

    # home.sessionVariables = {
    #   PIP_CONFIG_FILE = "${configHome}/pip/pip.conf";
    #   PIP_LOG_FILE = "${dataHome}/pip/log";
    #   PYLINTHOME = "${dataHome}/pylint";
    #   PYLINTRC = "${configHome}/pylint/pylintrc";
    #   PYTHONSTARTUP = "${configHome}/python/pythonrc";
    # };
  };
}
