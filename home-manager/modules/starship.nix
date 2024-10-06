{ lib, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[](gray)[](fg:blue bg:gray)$username[](gray) "
        "$directory"
        "$git_branch"
        "$git_status"
        "$docker_context"
        "$golang"
        "$nodejs"
        "$bun"
        "$lua"
        "$package"
        "$cmd_duration"
        "$fill"
        "$time"
        "$line_break"
        "$character"
      ];
      palette = "w";
      add_newline = false;
      character.success_symbol = "[❯](purple)";
      palettes.w = {
        blue = "#87AFFF";
        orange = "#FFAF87";
        gray = "#303030";
        purple = "#8b6bd8";
        red = "#FF5F5F";
        green = "#19B319";
      };
      fill.symbol = " ";
      time = {
        disabled = false;
        style = "fg:orange bg:gray";
        format = "[](gray)[ $time]($style)[](gray)";
        time_format = "%H:%M";
        utc_time_offset = "+3";
      };
      cmd_duration = {
        style = "fg:green bg:gray";
        format = "[](gray)[$duration]($style)[](gray)";
      };
      directory = {
        style = "orange";
        truncation_length = 6;
      };
      username = {
        style_user = "fg:blue bg:gray";
        style_root = "fg:red bg:gray";
        format = "[ $user]($style)";
        disabled = false;
        show_always = true;
      };
      git_branch = {
        symbol = "";
        style = "purple bold";
        format = "[$symbol $branch]($style) ";
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "blue bold";
        conflicted = "󰞇 ";
        untracked = " ";
        modified = " ";
        ahead = "⇡\${count} ";
        diverged = "⇕ ⇡ \${ahead_count} ⇣ \${behind_count} ";
        behind = "⇣\${count} ";
      };
      docker_context = {
        symbol = "";
        style = "blue bold";
        format = "[$symbol $context]($style) ";
      };
      golang = {
        symbol = "";
        format = "[$symbol $version](bold blue) ";
      };
      nodejs = {
        symbol = "󰎙";
        format = "[$symbol $version](bold green) ";
      };
      bun = {
        symbol = "󱔝";
        format = "[$symbol $version](bold blue) ";
      };
      lua = {
        symbol = "";
        format = "[$symbol $version](bold blue) ";
      };
      package = {
        format = "[\${symbol} \${version} \${name} \${up_to_date} ](bold ornage)";
      };
    };
  };
}
