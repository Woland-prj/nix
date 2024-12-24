{
  description = "PortProton installation flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    # Определение пакета PortProton для x86_64-linux
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
      pkgs.stdenv.mkDerivation rec {
        pname = "portproton";
        version = "latest";

        src = pkgs.fetchFromGitHub {
          owner = "portproton";
          repo = "portproton";
          rev = "master"; # укажите нужную ревизию или тег
          sha256 = "0vavksd82k6jshf23vnblqkvkba93h7s8zjd61dbd59bc4sfz20w"; # замените на актуальный sha256
        };

        nativeBuildInputs = [pkgs.git pkgs.curl pkgs.make pkgs.gcc];

        meta = with pkgs.lib; {
          description = "PortProton installer for Proton-based games";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      };

    # Определение NixOS модуля для интеграции PortProton в NixOS
    nixosModule = {
      config,
      pkgs,
      lib,
      ...
    }: {
      options = {};

      config = {
        environment.systemPackages = with pkgs; [
          portproton
        ];

        # Настроим запуск PortProton через systemd
        systemd.user.services.portproton = {
          description = "PortProton - Proton-based game installer";
          serviceConfig.ExecStart = "${pkgs.portproton}/bin/portproton";
          wantedBy = ["default.target"];
        };
      };
    };
  };
}
