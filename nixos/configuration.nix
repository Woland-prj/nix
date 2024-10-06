{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  disabledModules = [
    ./modules/efibootloader.nix
    ./modules/sound.nix
  ];

  networking.hostName = "wldnixos"; # Define your hostname.

  time.timeZone = "Europe/Moscow"; # Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enabling flakes

  system.stateVersion = "24.05"; # Don't change it bro
}
