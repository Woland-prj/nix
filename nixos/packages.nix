{
  pkgs,
  pkgs-stable,
  lib,
  ...
}: let
  scripts = {
    wttr = import ../scripts/wttr.nix {inherit pkgs;};
  };
in {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "codeium"
      ];
  };

  environment.systemPackages =
    (with pkgs; [
      # Desktop apps
      firefox
      telegram-desktop
      alacritty
      rofi
      wofi
      vlc
      obsidian
      libreoffice
      qbittorrent
      gnome-calculator
      cups
      playerctl
      insomnia
      writedisk
      eog

      # Gaming
      wine
      steam

      # Coding stuff
      gnumake
      gcc
      nodejs
      go
      python
      docker
      docker-compose
      pgadmin
      python3
      # (python313.withPackages (ps: with ps; [requests]))

      # CLI utils
      pfetch
      fastfetch
      file
      tree
      fzf
      fd
      bat
      eza
      starship
      tmux
      vim
      wget
      git
      btop
      nix-index
      unzip
      scrot
      ffmpeg
      imagemagick
      mediainfo
      zram-generator
      cava
      zip
      ntfs3g
      brightnessctl
      swww
      openssl
      lazygit
      xdg-user-dirs
      yazi

      # VPN
      xray

      # Wayland stuff
      xwayland
      wl-clipboard
      # cliphist

      # WMs and stuff
      pywal
      pywalfox-native
      xdg-desktop-portal-hyprland
      waybar
      wlogout

      # Sound
      pipewire
      wireplumber
      pulseaudio
      pamixer
      pavucontrol

      # GPU stuff

      # Screenshotting
      grim
      grimblast
      slurp

      # VM virtualization
      # qemu
      # quickemu

      # Other
      home-manager
      spice-vdagent
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      papirus-nord

      # Special custom scripts
      scripts.wttr
    ])
    ++ (with pkgs-stable; [
      # Stable hyprland
      hyprland
    ]);

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.jetbrains-mono
  ];
}
