{
  description = "PortProton installation flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem [
      "x86_64-linux"
    ] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.portproton = pkgs.stdenv.mkDerivation rec {
        pname = "portproton";
        version = "latest";

        src = pkgs.fetchFromGitHub {
          owner = "portproton";
          repo = "portproton";
          rev = "master";
          sha256 = "0vavksd82k6jshf23vnblqkvkba93h7s8zjd61dbd59bc4sfz20w";
        };

        nativeBuildInputs = [pkgs.git pkgs.curl pkgs.make pkgs.gcc];

        meta = with pkgs.lib; {
          description = "PortProton installer for Proton-based games";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      };

      # Возвращаем NixOS модуль для подключения
      nixosModule = import ./nixosModule.nix;
    });
}
