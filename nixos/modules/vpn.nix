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
                    "v2ray": [
                        {
                            "address": "cz1.vpnjantit.com", // Замените на адрес вашего сервера
                            "port": 10002,
                            "users": [
                                {
                                    "id": "b8c027fd-406b-4b76-b85f-ac3fa26b9530", // Ваш UUID
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
  systemd.services.xray = {
    description = "Xray Core VLESS Service";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.xray}/bin/xray -config ${xray-config}";
      Restart = "always";
      User = "nobody";
    };
  };
}