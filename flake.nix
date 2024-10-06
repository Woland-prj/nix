{
  description = "base nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.wldnixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system;
      };

      modules = [
        ./nixos/configuration.nix
      ];
    };

    homeConfigurations.woland = home-manager.lib.homeManagerConfiguration {
      pkgs =
        import nixpkgs
        {
          inherit system;
          config.allowUnfree = true;
        };
      modules = [
        ./home-manager/home.nix
        inputs.nixvim.homeManagerModules.nixvim
      ];
    };
  };
}
