{
  imports = [
    ./zsh.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  home = {
    username = "woland";
    homeDirectory = "/home/woland";
    stateVersion = "24.05";
  };
}
