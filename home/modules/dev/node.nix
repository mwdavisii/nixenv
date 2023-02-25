{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nyx.modules.dev.node;
  boolToString = v: if v then "true" else "false";
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
  cacheHome = config.xdg.cacheHome;
in
{
  home.packages = with pkgs; [ nodejs yarn ];
  home.sessionVariables = {
    NPM_CONFIG_USERCONFIG = "${configHome}/npm/config";
    NPM_CONFIG_CACHE = "${configHome}/npm";
    PM_CONFIG_TMP = "${cacheHome}/tmp/npm";
    NPM_CONFIG_PREFIX = "${dataHome}/npm";
    NODE_REPL_HISTORY = "${cacheHome}/node/repl_history";
  };
}
