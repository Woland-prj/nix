{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      TERM = "xterm-256color";
      LC_ALL = "en_US.UTF-8";
      LANG = "ru_RU.UTF-8";
      BAT_THEME = "OneHalfDark";
      NIXPKGS_ALLOW_UNFREE = 1;
    };

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zdharma/fast-syntax-highlighting";}
        {name = "zsh-users/zsh-completions";}
        {name = "zsh-users/zsh-history-substring-search";}
        {name = "MichaelAquilina/zsh-you-should-use";}
      ];
    };

    # autostart wm
    # zprof.enable = true;
    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';

    shellAliases = let
      flakeDir = "~/nix";
    in {
      # base
      ls = "eza --color=always --long --git --icons=always --no-time --no-user --no-permissions";
      lsa = "eza --color=always --long --git --icons=always --no-time --no-user --no-permissions -a";
      lsl = "eza --color=always --long --git --icons=always -a";
      c = "clear";
      e = "exit";
      n = "nvim";
      v = "vim";
      y = "yazi";

      # fan
      b = "cbonsai -S";
      p = "pipes.sh -t 3 -p 3";

      # nix
      rs = "sudo nixos-rebuild switch --flake ${flakeDir}";
      upd = "nix flake update ${flakeDir}";
      upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";

      hms = "home-manager switch --flake ${flakeDir}";

      conf = "nvim ${flakeDir}/nixos/configuration.nix";
      pkgs = "nvim ${flakeDir}/nixos/packages.nix";

      # git
      gi = "git init";
      ga = "git add .";
      gp = "git push";
      gc = "git commit";
      gcl = "git clone";
      gpl = "git pull";
      gck = "git checkout ";
      gm = "git merge ";
      lg = "lazygit";

      # docker
      dcr = "docker ";
      dcmp = "docker-compose";
      dcmpb = "docker-compose build";
      dcmpu = "docker-compose up -d";
      dcmpd = "docker-compose down";

      # BIG, DATA
      cdbig = "cd /mnt/BIG";
      cddata = "cd /mnt/DATA";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initExtra = ''
      (cat ~/.cache/wal/sequences &)
      source ~/.cache/wal/colors-tty.sh
      pfetch
    '';
  };
}
