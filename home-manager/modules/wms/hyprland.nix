{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    sourceFirst = true;

    settings = {
      # Pywal colors
      "source" = "~/.cache/wal/colors-hyprland.conf";

      # Monitors setup
      # monitor = ",1920x1080,auto,1";
      monitor = [
        "DP-2,2560x1440@165,1080x0,1"
        "HDMI-A-1,1920x1080@60,0x0,1,transform,1"
      ];

      # Autostart
      exec-once = [
        # Load Dunst Notification Manager
        "dunst"

        # Load cliphist history
        # "wl-paste --watch cliphist store"

        # Run tmux server
        "tmux"

        # Initialize wallpaper engine
        "swww-daemon"

        # Load wallpaper and color scheme
        "~/nix/scripts/wallpapers.sh init"

        # Load last wallpaper and waybar with pywal colors
        "waybar"

        # Load cava
        "alacritty --title=cava -e cava"

        # telegram
        "telegram-desktop"
      ];

      # Environment
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
      ];

      # Keyboard
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0;
      };

      # Window
      general = {
        gaps_in = 8;
        gaps_out = 12;
        border_size = 3;
        "col.active_border" = "$color3";
        "col.inactive_border" = "rgba(282828cc)";
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
        };
        active_opacity = "1.0";
        inactive_opacity = "0.8";
        fullscreen_opacity = "1.0";

        drop_shadow = true;
        shadow_range = 30;
        shadow_render_power = 3;
        "col.shadow" = "0x66000000";
      };

      # Animation
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Layouts
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_invert = false;
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      # Misc
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
      };

      # Keybindings
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$filemanager" = "thunar";
      "$vscode" = "code";
      "$calc" = "gnome-calculator";
      "$telegram" = "telegram-desktop";
      "$browser" = "firefox";
      "$obsidian" = "obsidian";
      "$torrent" = "qbittorrent";

      "$tmux" = "tmux -2 new-session -A -s";
      "$fetch" = "fastfetch";

      bind = [
        # Apps binds
        "$mainMod, C, exec, $vscode"
        "$mainMod, M, exec, $telegram --title=telegram"
        "$mainMod, E, exec, $filemanager"
        "$mainMod, O, exec, $obsidian"
        "$mainMod, B, exec, $browser"
        "$mainMod, I, exec, $insomnia"
        "$mainMod, RETURN, exec, $terminal --title=terminal -e $tmux main "
        "$mainMod SHIFT, RETURN, exec, $terminal"
        "$mainMod, Z, exec, $zed"
        "$mainMod SHIFT, N, exec, $terminal --title=fetch --hold -e $fetch"
        "$mainMod SHIFT, T, exec, $torrent"
        "$mainMod ALT, T, exec, $terminal"

        # Numpad apps bind
        ", KP_Divide, exec, $browser --new-tab https://www.youtube.com/"

        # Function row binds
        ", XF86Tools, exec, $browser --new-tab https://music.yandex.ru/home"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -3%"
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +3%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"

        ", XF86Mail, exec, $mail"
        ", XF86HomePage, exec, $browser --new-tab http://127.0.0.1:8384/"
        ", XF86Calculator, exec, $calc"

        # Windows layout & actions
        "$mainMod, X, killactive"
        "$mainMod, F, fullscreen"
        "$mainMod, T, togglefloating"
        "$mainMod, I, togglesplit"

        # Focus moving
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Base scripts
        ", PRINT, exec, slurp | grim -g - $HOME/Pictures/screenshots/$(date +'screenshot_%Y-%m-%d-%H%M%S.png')"
        "$mainMod, S, exec, slurp | grim -g - $HOME/Pictures/screenshots/$(date +'screenshot_%Y-%m-%d-%H%M%S.png')"
        "$mainMod, Q, exec, loginctl terminate-user woland"
        "$mainMod CTRL, RETURN, exec, rofi -show drun -config ~/.config/rofi/conf.rasi -theme ~/.config/rofi/config-main.rasi"
        "$mainMod SHIFT, B, exec, $HOME/nix/scripts/launch_waybar.sh"
        "$mainMod CTRL, C, exec, $terminal --title=cava -e cava -p ~/dotfiles/cava/config "
        "$mainMod, W, exec, $HOME/nix/scripts/wallpapers.sh select"

        # Hyprpicker
        "$mainMod, P, exec, hyprpicker -an"

        # Switching workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        ", KP_End, workspace, 1"
        ", KP_Down, workspace, 2"
        ", KP_Next, workspace, 3"
        ", KP_Left, workspace, 4"
        ", KP_Begin, workspace, 5"
        ", KP_Right, workspace, 6"
        ", KP_Home, workspace, 7"
        ", KP_Up, workspace, 8"
        ", KP_Prior, workspace, 9"
        ", KP_Insert, workspace, 10"

        "$mainMod ALT, l, workspace, e+1"
        "$mainMod ALT, h, workspace, e-1"

        # Moving to workspaces
        "$mainMod ALT, right, workspace, e+1"
        "$mainMod ALT, left, workspace, e-1"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Window resizing
        "$mainMod CTRL, right, resizeactive, 100 0"
        "$mainMod CTRL, left, resizeactive, -100 0"
        "$mainMod CTRL, up, resizeactive, 0 -100"
        "$mainMod CTRL, down, resizeactive, 0 100"

        "$mainMod CTRL, l, resizeactive, 100 0"
        "$mainMod CTRL, h, resizeactive, -100 0"
        "$mainMod CTRL, k, resizeactive, 0 -100"
        "$mainMod CTRL, j, resizeactive, 0 100"

        # Window swaping
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, left, swapwindow, l"
        "$mainMod SHIFT, up, swapwindow, u"
        "$mainMod SHIFT, down, swapwindow, d"

        "$mainMod SHIFT, l, swapwindow, r"
        "$mainMod SHIFT, h, swapwindow, l"
        "$mainMod SHIFT, k, swapwindow, u"
        "$mainMod SHIFT, j, swapwindow, d"

        # Window moving
        "$mainMod, l, movefocus, r"
        "$mainMod, h, movefocus, l"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Mouse actions
        "$mainMod, mouse_up, workspace, e+1"
        "$mainMod, mouse_down, workspace, e-1"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Windowrules
      workspace = [
        "9,monitor:HDMI-A-1"
        "10,monitor:HDMI-A-1"
        "1,monitor:DP-2,default=true"
      ];
      windowrulev2 = [
        # terminal
        "float,title:^terminal"
        "size 35% 45%,title:^terminal"
        "center,title:^terminal"
        "monitor DP-2,title:^terminal"
      ];
      windowrule = [
        # network manager
        "float,title:^(network)$"
        "size 700 600,title:^(network)$"
        "move 100%-735 90,title:^(network)$"

        # youtube
        "move 15 15,title:^(Картинка в картинке)"
        "float,title:^(Картинка в картинке)"
        "size 1050 591,title:^(Картинка в картинке)"
        "opacity 1.0 override 1.0 override 1.0 override 1.0,title:(.*)(- YouTube — Mozilla Firefox)$"
        "opacity 1.0 override 1.0 override 1.0 override 1.0,title:^(Картинка в картинке)"
        "workspace 10,title:^(Картинка в картинке)"

        # picture in picture
        "move 15 15,title:^(Picture-in-Picture)"
        "float,title:^(Picture-in-Picture)"
        "size 1050 591,title:^(Picture-in-Picture)"
        "opacity 1.0 override 1.0 override 1.0 override 1.0,title:^(Picture-in-Picture)"
        "workspace 10,title:^(Picture-in-Picture)"

        # torrent
        "float,^(org.qbittorrent.qBittorrent)$"
        "size 1050 591,^(org.qbittorrent.qBittorrent)$"
        "move 15 15,^(org.qbittorrent.qBittorrent)$"
        "workspace 10,^(org.qbittorrent.qBittorrent)$"

        # cava music
        "float,title:^(cava)"
        "size 1050 450,title:^(cava)"
        "move 15 621,title:^(cava)"
        "noborder, title:^(cava)"
        "workspace 10,title:^(cava)"

        # fetch
        "float,title:^(fetch)"
        "size 1305 650,title:^(fetch)"
        "center,title:^(fetch)"

        # tg
        "float,title:^(Telegram)"
        "size 1050 819,title:^(Telegram)"
        "move 15 1086,title:^(Telegram)"
        "workspace 10,title:^(Telegram)"

        # calc
        "float,^(org.gnome.Calculator)$"
        "size 375 615,^(org.gnome.Calculator)$"
        "move 100%-410 90,^(org.gnome.Calculator)$"

        # pavucontrol
        "float,^(pavucontrol)$"
        "size 420 350,^(pavucontrol)$"
        "move 100%-455 90,^(pavucontrol)$"

        "float,^(org.pulseaudio.pavucontrol)$"
        "size 420 350,^(org.pulseaudio.pavucontrol)$"
        "move 100%-455 90,^(org.pulseaudio.pavucontrol)$"

        # rofi - dmenu
        "float,title:^(rofi - dmenu)"
        "center,title:^(rofi - dmenu)"
        "noborder,title:^(rofi - dmenu)"

        # rofi
        "float,^(Rofi)$"
        "center,^(Rofi)$"
        "noborder,^(Rofi)$"

        # obsidian
        "float,^(obsidian)$"
        "size 1640 950,^(obsidian)$"
        "center,^(obsidian)$"
      ];
    };
  };
}
