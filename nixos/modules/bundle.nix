{
  imports = [
    ./legacybootloader.nix
    ./efibootloader.nix
    ./sound.nix
    ./zram.nix
    ./env.nix
    ./user.nix
    ./nm.nix
    ./ssh.nix
    ./hyprland.nix
    ./nvidia.nix
    ./thunar.nix
    ./fs.nix
    ./docker.nix
    ./gc.nix
    ./vpn.nix
    ./flatpak.nix

    ./kanata/kanata.nix
    # ./stylix.nix
  ];
}
