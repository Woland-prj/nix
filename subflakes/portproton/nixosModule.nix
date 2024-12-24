{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    # Здесь вы можете добавить настройки для PortProton, если они понадобятся
  };

  config = {
    # Устанавливаем необходимые зависимости для PortProton
    environment.systemPackages = with pkgs; [
      git
      curl
      make
      gcc
      portproton
    ];

    # Настроим запуск PortProton
    systemd.user.services.portproton = {
      description = "PortProton - Proton-based game installer";
      serviceConfig.ExecStart = "${pkgs.portproton}/bin/portproton";
      wantedBy = ["default.target"];
    };
  };
}
