{pkgs, ...}: let
  xray-config = pkgs.writeText "xray-config.json" ''
    {
        "inbounds": [
            {
                "port": 1080,
                "protocol": "socks",
                "settings": {
                    "auth": "noauth"
                }
            }
        ],
        "outbounds": [
            {
                "protocol": "vless",
                "settings": {
                    "vnext": [
                        {
                            "address": "cz1.vpnjantit.com", // Замените на адрес вашего сервера
                            "port": 10002,
                            "users": [
                                {
                                    "id": "f8f9969e-bae0-11ef-904f-52cf00e461ad", // Ваш UUID
                                    "encryption": "none"
                                }
                            ]
                        }
                    ]
                },
                "streamSettings": {
                    "network": "tcp",
                    "security": "tls",
                    "tlsSettings": {
                        "serverName": "cz1.vpnjantit.com" // Замените на адрес вашего сервера
                    }
                }
            }
        ]
    }
  '';
in {
  # systemd.services.xray = {
  # description = "Xray Core VLESS Service";
  # wantedBy = ["multi-user.target"];
  # serviceConfig = {
  # ExecStart = "${pkgs.xray}/bin/xray -config ${xray-config}";
  # Restart = "always";
  # User = "nobody";
  # };
  # };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "run-xray" ''
      #!/usr/bin/env bash
      ${pkgs.xray}/bin/xray -config ${xray-config}
    '')
  ];
}
