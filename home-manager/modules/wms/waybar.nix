{
  pkgs,
  lib,
  ...
}: let
  playerctl = lib.getExe pkgs.playerctl;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        output = "DP-2";
        margin = "10 10 0 10";
        spacing = "0";

        modules-left = [
          "tray"
          "hyprland/language"
          "custom/playerlabel"
        ];
        modules-center = ["hyprland/workspaces"];
        modules-right = [
          "network"
          "pulseaudio"
          "group/hardware"
          "clock"
          "custom/weather"
          "custom/exit"
        ];

        "group/hardware" = {
          orientation = "horizontal";
          modules = [
            "custom/mem"
            "cpu"
          ];
          on-click = "alacritty --title=cpu -e btop";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          all-outputs = true;
          activate-only = false;
          on-click = "activate";
          format-icons = {
            urgent = "";
            activate = "";
            default = "";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 16;
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [
            "Alacritty"
          ];
        };

        "hyprland/language" = {
          format = "{} 󰌌";
          format-en = "US";
          format-ru = "RU";
          on-click = "hyprctl switchxkblayout gaming-keyboard next";
        };

        "custom/playerlabel" = {
          format = "<span>{}</span> 󰝚";
          return-type = "json";
          max-length = 30;
          exec = "${playerctl} -a metadata --format '{\"text\": \"{{markup_escape(title)}} - {{artist}}\": \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          format-icons = {
            "Playing" = "<span foreground='#FFFFFF'>󰒮 󰐌 󰒭</span>";
            "Paused" = "<span foreground='#888888'>󰒮 󰏥 󰒭</span>";
          };
        };

        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%H:%M}";
        };

        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 1800;
          exec = "python -u $HOME/nix/home-manager/modules/wms/scripts/wttr.py";
          return-type = "json";
        };

        "pulseaudio" = {
          reverse-scrolling = 1;
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "󰖁";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
          on-click-middle = "pactl set-sink-mute 0 toggle";
        };

        "custom/mem" = {
          format = "{} ";
          interval = 3;
          exec = "free -h | awk '/Mem:/{printf $3}'";
          tooltip = false;
        };

        "custom/updates" = {
          format = "{} ";
          tooltip-format = "{}";
          escape = true;
          return-type = "json";
          exec = "~/dotfiles/scripts/updates.sh";
          restart-interval = 60;
          on-click = "alacritty --title=updates -e ~/dotfiles/scripts/installupdates.sh";
          on-click-right = "~/dotfiles/.settings/software.sh";
          tooltip = false;
        };

        "network" = {
          format = "{ifname}";
          format-wifi = "{essid}   {bandwidthDownBits} ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = "Disconnected 󰅛";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected 󰅛";
          max-length = 50;
          on-click = "alacritty --title=network -e nmtui";
        };

        "cpu" = {
          interval = 10;
          format = "{}% ";
          max-lenght = 10;
        };

        "tray" = {
          icon-size = 16;
          spacing = 8;
        };

        "custom/exit" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
        };
      };
    };
    style = ''
      @import "/home/woland/.cache/wal/colors-waybar.css";

      /* :root { */
      /*   --bg-color: rgba(40, 40, 40, 0.6); */
      /* } */

      * {
        border: none;
        border-radius: 0;
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: JetBrainsMono Nerd Font;
        min-height: 30px;
        color: @color2;
        font-weight: bold;
      }

      window#waybar {
        background: transparent;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces {
        background-color: rgba(40, 40, 40, 0.6);
        border-radius: 40px;
        padding: 5px 5px;
      }

      #workspaces button {
        padding: 0;
        background: @color3;
        transition: all 0.3s ease;
        border-radius: 40px;
        margin-right: 10px;
        min-width: 30px;
      }
      /* #bc8ad2 */
      #workspaces button.active {
        background: @color5;
        min-width: 50px;
      }

      #workspaces button:last-child {
        margin-right: 0px;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
        text-shadow: none;
        background: @color6;
      }

      #taskbar {
        margin-right: 8px;
        padding: 5px 10px;
        border-radius: 40px;
        background-color: rgba(40, 40, 40, 0.6);
      }

      /* #taskbar.empty { */
      /*   background-color: ; */
      /* } */

      #taskbar button {
        margin-right: 10px;
        padding: 0;
        transition: all 0.3s ease;
        border-radius: 6px;
      }

      #taskbar button:last-child {
        margin-right: 0px;
      }

      #taskbar button:hover {
        text-shadow: none;
        background: transparent;
      }

      #language {
        padding-left: 16px;
        margin-right: 8px;
        padding-right: 16px;
        border-radius: 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #custom-pacman {
        padding-left: 16px;
        padding-right: 8px;
        border-radius: 10px 0px 0px 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
      }

      #custom-mail {
        margin-right: 8px;
        padding-right: 16px;
        border-radius: 0px 10px 10px 0px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
      }

      #custom-playerlabel {
        margin-right: 8px;
        padding-right: 16px;
        padding-left: 16px;
        border-radius: 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #mode {
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
      }

      #clock {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #custom-weather {
        margin-right: 8px;
        padding-right: 16px;
        padding-left: 16px;
        border-radius: 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #network {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #pulseaudio {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #pulseaudio.muted {
        background-color: @color15;
        color: @color11;
      }

      #custom-mem {
        padding-left: 16px;
        padding-right: 8px;
        border-radius: 40px 0 0 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #cpu {
        margin-right: 8px;
        padding-left: 8px;
        padding-right: 16px;
        border-radius: 0 40px 40px 0;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #temperature {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #6c61db;
      }

      #temperature.critical {
        background-color: #eb4d4b;
      }

      #backlight {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
      }

      #battery {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
      }

      #battery.charging {
        color: #ffffff;
        background-color: #26a65b;
      }

      #battery.warning:not(.charging) {
        background-color: #ffbe61;
        color: black;
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #tray {
        padding-left: 16px;
        padding-right: 16px;
        margin-right: 8px;
        border-radius: 40px;
        transition: none;
        color: @color3;
        background-color: rgba(40, 40, 40, 0.6);
      }

      #custom-exit {
        /* padding-left: 16px; */
        /* padding-right: 16px; */
        font-size: 26px;
        margin-left: -8px;
        /* text-align: center; */
        color: @color3;
        min-width: 33px;
      }

      #custom-updates {
        padding-left: 16px;
        margin-right: 8px;
        padding-right: 16px;
        border-radius: 40px;
        background-color: rgba(40, 40, 40, 0.6);
        color: @color3;
        transition: none;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }
    '';
  };
}
