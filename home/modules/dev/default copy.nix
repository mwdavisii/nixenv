/* { ... }:

{
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./exa.nix
    ./fzf.nix
    ./git.nix
    ./glow.nix
    ./gnupg.nix
    ./keybase.nix
    ./lf.nix
    ./lorri.nix
    ./mcfly.nix
    ./neovim.nix
    ./nushell.nix
    ./repo.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./vale.nix
    ./xdg.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
*/
{ lib, ... }:

with builtins;
with lib;
{
  imports =
    let
      paths = filterAttrs (n: v: v != null && !(hasPrefix "_" n)) (readDir ./.);
      files = filterAttrs (n: v: v == "regular" && n != "default.nix") paths;
      dirs = filterAttrs (n: v: v == "directory") paths;
      map' = p: map (x: "${toString ./.}/${x}") (attrNames p);
    in
    map' dirs ++ map' files;
}
