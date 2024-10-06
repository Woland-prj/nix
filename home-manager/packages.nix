{pkgs, ...}: let
  scripts = {
    wttr = import ../scripts/wttr.nix {inherit pkgs;};
  };
in {
  home.packages = [
    scripts.wttr
  ];
}
