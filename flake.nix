{
  description = "base nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";

    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    portproton-flake.url = "path:/home/woland/nix/subflakes/portproton";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    portproton-flake,
    ...
  } @ inputs:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "wldnixos"; # hostname
        profile = "personal"; # select a profile defined from my profiles directory
        timezone = "Europe/Moscow"; # select timezone
        locale = "en_US.UTF-8"; # select locale
        bootMode = "uefi"; # uefi or bios
        bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
        grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
        gpuType = "nvidia"; # amd, intel or nvidia; only makes some slight mods for amd at the moment
      };

      # ----- USER SETTINGS ----- #
      userSettings = {
        username = "woland"; # username
        name = "Woland"; # name/identifier
        email = "nzimin93@gmail.com"; # email (used for certain configurations)
        flakeDir = "~/nix"; # absolute path of the local repo
        theme = "catppuccin-mocha"; # selcted theme from my themes directory (./themes/)
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        term = "alacritty"; # Default terminal command;
        font = "JetBrains Mono NF"; # Selected font
        fontPkg = pkgs.nerdfonts; # Font package
        editor = "nvim"; # Default editor;
      };
      system = systemSettings.system;
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs =
        import nixpkgs
        {
          inherit system;
          config.allowUnfree = true;
        };
    in {
      nixosConfigurations.wldnixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit pkgs-stable;
          inherit userSettings;
          inherit systemSettings;
          inherit inputs;
        };

        modules = [
          ./nixos/configuration.nix
          portproton-flake.nixosModule
        ];
      };

      homeConfigurations.woland = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
        ];
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit userSettings;
          inherit systemSettings;
          inherit inputs;
        };
      };

      defaultPackage = self.packages.${system}.portproton;
    });
}
